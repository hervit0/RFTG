require 'yaml'
require_relative 'services/players.rb'
require_relative 'services/state.rb'
require_relative 'views/welcome.rb'
require_relative 'views/blank.rb'
require_relative 'views/player.rb'
require_relative 'views/phases.rb'

module Router
  SESSION = "session"
  SESSION_ID = "rftg1"

  module Method
    POST = "POST"
    GET = "GET"
  end

  module Path
    PLAYERS_NAMES = "/players_names"
    BEGIN_DISCARD = "/begin_discard"
    INTRODUCE_PLAYER = "/introduce_player"
    DISCARD = "/discard"
    SHOW_KEPT_CARDS = "/show_kept_cards"
    CHOOSE_PHASES = "/choose_phases"
  end

  class Controller
    def self.select_body(env)
      request = Rack::Request.new(env)
      @method = request.request_method
      @path = request.path

      if key(Path::PLAYERS_NAMES, Method::POST)
        Service::State.marshal_players_number(request)
        View::Blank.show

      elsif key(Path::PLAYERS_NAMES, Method::GET)
        players_number = Service::State.players_number(request)
        View::Player.give_name(Path::BEGIN_DISCARD, Method::POST, players_number)

      elsif key(Path::BEGIN_DISCARD, Method::POST)
        Service::State.initialize_game(request)
        View::Blank.show

      elsif key(Path::BEGIN_DISCARD, Method::GET)
        View::Player.begin_discard(Path::INTRODUCE_PLAYER, Method::POST)

      elsif key(Path::INTRODUCE_PLAYER, Method::POST)
        Service::Player.marshal_introduce(request)
        View::Blank.show

      elsif key(Path::INTRODUCE_PLAYER, Method::GET)
        player = Service::Player.introduce(request)
        View::Player.introduce(Path::DISCARD, Method::GET, player.name)

      elsif key(Path::DISCARD, Method::GET)
        path, player = Service::Player.discard(request)
        View::Player.discard_cards(path, Method::POST, player.name, player.hand)

      elsif key(Path::CHOOSE_PHASES, Method::POST)
        Service::State.apply_discard(request)
        View::Blank.show

      elsif key(Path::CHOOSE_PHASES, Method::GET)
        View::Phase.choose

      else
        View::Welcome.display(Path::PLAYERS_NAMES, Method::POST)
      end
    end

    def self.key(current_path, current_method)
      @path == current_path && @method == current_method
    end

    private_class_method :key

  end
end
