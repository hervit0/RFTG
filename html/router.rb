require 'yaml'
require_relative 'welcome.rb'
require_relative 'names.rb'
require_relative 'discard.rb'
require_relative '../player.rb'

class Router
  def self.select_body(env)
    request = Rack::Request.new(env)
    method = request.request_method
    url = request.url

    if url == "http://rftg/players_names" && method == "POST"
      player_number = request.POST.values.first.to_i
      Names.new(player_number).give_name

    elsif url == "http://rftg/discard" && method == "POST"
      names = request.POST.to_a.map.with_index do |x, i|
        if i == 0
          {"name" => x[1], "status" => :discarded}
        else
          {"name" => x[1], "status" => :not_discarded}
        end
      end
      File.write("names.yml", names.to_yaml)
      Discard.new(names[0]["name"], "discard_next_player").discard_cards

    elsif url == "http://rftg/discard_next_player" && method == "POST"
      names = YAML.load(File.read("names.yml"))
      status = names.map{ |x| x["status"]}
      action = if status.count(:not_discarded) == 1
                 "choose_phases"
               else
                 "discard_next_player"
               end
      Discard.new("the last", action).discard_cards

    elsif url == "http://rftg/choose_phases" && method == "POST"

    else
      Welcome.display
    end
  end
end
