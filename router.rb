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

      if key(Path::PLAYERS_NAMES, METHOD_POST)
        players_number = Service::Player.number(request)
        View::Player.give_name(Path::BEGIN_DISCARD, players_number)




      elsif key(Path::BEGIN_DISCARD, METHOD_POST)
        Service::State.initialize_game(request)
        View::Player.begin_discard(Path::INTRODUCE_PLAYER)





      elsif key(Path::INTRODUCE_PLAYER, METHOD_POST)
        player = Service::Player.introduce(request)
        View::Player.introduce(Path::DISCARD, player.name)

      elsif key(Path::DISCARD, METHOD_POST)
        path, player = Service::Player.discard(request)
        View::Player.discard_cards(path, player.name, player.hand)







    #  elsif key(Path::SHOW_KEPT_CARDS, METHOD_POST)
     #   path, player = Service::Player.show_kept_cards(request)
     #   View::Player.show_kept_cards(path, player.name, player.hand)






      elsif key(Path::CHOOSE_PHASES, METHOD_POST)
        Service::State.apply_discard(request)
        View::Phase.choose

      else
        View::Welcome.display(Path::PLAYERS_NAMES)
      end
    end

    def self.key(current_path, current_method)
      @path == current_path && @method == current_method
    end

    private_class_method :key

  end
end
