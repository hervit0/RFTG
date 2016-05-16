require 'yaml'
require_relative 'errors.rb'
require_relative 'settings.rb'
require_relative 'control/players.rb'
require_relative 'control/state.rb'
require_relative 'control/session.rb'
require_relative 'services/players.rb'
require_relative 'services/state.rb'
require_relative 'views/welcome.rb'
require_relative 'views/blank.rb'
require_relative 'views/player.rb'
require_relative 'views/phases.rb'
require_relative 'views/errors.rb'

module Router
  SESSION = :session
  SESSION_ID = :rftg1

  module Method
    POST = :POST
    GET = :GET
  end

  module Path
    PLAYERS_NAMES = '/players_names'.freeze
    BEGIN_DISCARD = '/begin_discard'.freeze
    INTRODUCE_PLAYER = '/introduce_player'.freeze
    DISCARD = '/discard'.freeze
    SHOW_KEPT_CARDS = '/show_kept_cards'.freeze
    CHOOSE_PHASES = '/choose_phases'.freeze
  end

  class Controller
    def self.select_body(env)
      @request = Rack::Request.new(env)
      @method = @request.request_method
      @path = @request.path
      @id = Control::Session.id(@request)

      select_view do |state|
        if key(Path::PLAYERS_NAMES, Method::POST)
          players_number = Control::State.players_number(@request)
          [Service::State.marshal_players_number(players_number),
           View::Blank.show]

        elsif key(Path::PLAYERS_NAMES, Method::GET)
          players_number = Service::State.players_number(state)
          [state,
           View::Player.give_name(Path::BEGIN_DISCARD, Method::POST, players_number)]

        elsif key(Path::BEGIN_DISCARD, Method::POST)
          players_names = Control::State.players_names(@request)
          [Service::State.initialize_game(players_names),
           View::Blank.show]

        elsif key(Path::BEGIN_DISCARD, Method::GET)
          [state,
           View::Player.begin_discard(Path::INTRODUCE_PLAYER, Method::POST)]

        elsif key(Path::INTRODUCE_PLAYER, Method::POST)
          cards = Control::Players.initial_cards(@request)
          [Service::Player.choose_initial_cards(state, cards),
           View::Blank.show]

        elsif key(Path::INTRODUCE_PLAYER, Method::GET)
          path, player = Service::Player.introduce(state)
          [state,
           View::Player.introduce(Path::DISCARD, Method::GET, player.name)]

        elsif key(Path::DISCARD, Method::GET)
          path, player = Service::Player.introduce(state)
          [state,
           View::Player.discard_cards(path, Method::POST, player.name, player.hand)]

        elsif key(Path::CHOOSE_PHASES, Method::POST)
          first_card, second_card = Control::State.discarded_cards(@request)
          [Service::State.make_player_discard(state, first_card, second_card),
           View::Blank.show]

        elsif key(Path::CHOOSE_PHASES, Method::GET)
          [state,
           View::Phase.choose]

        else
          [state,
           View::Welcome.display(Path::PLAYERS_NAMES, Method::POST)]

        end
      end
    end

    def self.select_view
      state = Persistence::Storage.new(Settings::STORAGE_TYPE).read_state(@id)
      new_state, view = yield state
      Persistence::Storage.new(Settings::STORAGE_TYPE).save_state(@id, new_state)
      view
    end

    def self.error(error_type)
      errors_messages = {
        Error::EmptyPost =>
        'No data received !',
          Error::NoPlayersNames =>
        'No name was given, so sad !',
          Error::NoCookieInRequest =>
        'Problem about cookies, did you allow its?',
          Error::NoSessionID =>
        'Problem about session, did you allow cookies?',
          Error::NotInteger =>
        'Sorry, integer was excepted...',
          Error::UnexpectedNumberOfInputs =>
        'Did you send the correct number of inputs ?',
          Error::UnexpectedNumberOfCards =>
        'Did you choose 2 cards among 6 cards ?',
          Error::TooManyPlayers =>
        'Warning, RFTG is designed for only 4 players',
          Error::NotEnoughPlayers =>
        'At least 2 players are expected.',
          Error::UnavailableIndexOfCard =>
        'Did you choose among the six cards ?'
      }

      message = errors_messages.values_at(error_type).shift
      [404, View::Error.badrequest(message)]
    end

    def self.key(current_path, current_method)
      @path == current_path && @method == current_method
    end

    private_class_method :key, :select_view

  end
end
