require 'yaml'
require_relative 'services/players.rb'
require_relative 'views/welcome.rb'
require_relative 'views/names.rb'
require_relative 'views/discard.rb'
require_relative 'views/phases.rb'

class Router
  def self.select_body(env)
    request = Rack::Request.new(env)
    method = request.request_method
    url = request.url

    if url == "http://rftg/players_names" && method == "POST"
      players_number = Service::Player.number(request)
      Names.new(players_number).give_name

    elsif url == "http://rftg/begin_discard" && method == "POST"
      Service::State.initialize_game(request)
      Discard.begin_discard

    elsif url == "http://rftg/present_player" && method == "POST"
      player_name, player_hand = Service::Player.present(request)
      Discard.present_players(player_name)

    elsif url == "http://rftg/discard" && method == "POST"
      player_name, player_hand = Service::Player.present(request)
      Discard.discard_cards(player_name, player_hand)

    elsif url == "http://rftg/show_kept_cards" && method == "POST"
      action, player_name, player_hand = Service::Player.show_kept_cards(request)
      Discard.show_kept_cards(action, player_name, player_hand)

    elsif url == "http://rftg/choose_phases" && method == "POST"
      Phase.choose

    else
      Welcome.display
    end
  end
end

