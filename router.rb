require 'yaml'
require_relative 'services/players.rb'
require_relative 'views/welcome.rb'
require_relative 'views/names.rb'
require_relative 'views/discard.rb'

class Router
  def self.select_body(env)
    request = Rack::Request.new(env)
    method = request.request_method
    url = request.url

    if url == "http://rftg/players_names" && method == "POST"
      players_number = Players.number(request)
      Names.new(players_number).give_name

    elsif url == "http://rftg/begin_discard" && method == "POST"
      Players.names(request)
      Discard.begin_discard

    elsif url == "http://rftg/present_player" && method == "POST"
      player_index, player_name = Players.present
      Discard.present_players(player_name)

    elsif url == "http://rftg/discard" && method == "POST"
      action, player_name = Players.discard
      Discard.discard_cards(action, player_name)

    elsif url == "http://rftg/choose_phases" && method == "POST"

    else
      Welcome.display
    end
  end
end

