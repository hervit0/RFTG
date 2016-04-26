require 'yaml'
require_relative 'services/players.rb'
require_relative 'services/state.rb'
require_relative 'views/welcome.rb'
require_relative 'views/player.rb'
require_relative 'views/phases.rb'

module Router
  METHOD_POST = "POST"
  SESSION = "session"
  SESSION_ID = "rftg1"
  PATH_PLAYERS_NAMES = "/players_names"
  PATH_BEGIN_DISCARD = "/begin_discard"
  PATH_PRESENT_PLAYER = "/present_player"
  PATH_DISCARD = "/discard"
  PATH_SHOW_KEPT_CARDS = "/show_kept_cards"
  PATH_CHOOSE_PHASES = "/choose_phases"

  class Controller
    def self.select_body(env)
      request = Rack::Request.new(env)
      @method = request.request_method
      @path = request.path

      if key(Router::PATH_PLAYERS_NAMES, Router::METHOD_POST)
        players_number = Service::Player.number(request)
        View::Player.give_name(players_number)

      elsif key(Router::PATH_BEGIN_DISCARD, Router::METHOD_POST)
        Service::State.initialize_game(request)
        View::Player.begin_discard

      elsif key(Router::PATH_PRESENT_PLAYER, Router::METHOD_POST)
        player_name, player_hand = Service::Player.present(request)
        View::Player.present(player_name)

      elsif key(Router::PATH_DISCARD, Router::METHOD_POST)
        player_name, player_hand = Service::Player.present(request)
        View::Player.discard_cards(player_name, player_hand)

      elsif key(Router::PATH_SHOW_KEPT_CARDS, Router::METHOD_POST)
        action, player_name, player_hand = Service::Player.show_kept_cards(request)
        View::Player.show_kept_cards(action, player_name, player_hand)

      elsif key(Router::PATH_CHOOSE_PHASES, Router::METHOD_POST)
        View::Phase.choose

      else
        View::Welcome.display
      end
    end

    def self.key(current_path, current_method)
      @path == current_path && @method == current_method
    end

    private_class_method :key

  end
end
