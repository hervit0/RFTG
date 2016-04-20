require 'yaml'
require_relative 'welcome.rb'
require_relative 'names.rb'
require_relative 'discard.rb'
require_relative '../player.rb'
require_relative '../stack.rb'
require_relative '../hand.rb'

class Router
  def self.select_body(env)
    request = Rack::Request.new(env)
    method = request.request_method
    url = request.url

    if url == "http://rftg/players_names" && method == "POST"
      player_number = request.POST.values.first.to_i
      Names.new(player_number).give_name

    elsif url == "http://rftg/discard" && method == "POST"
      names = request.POST.to_a.map do |x|
        {"name" => x[1], "status" => :not_discarded}
      end
      File.write("names.yml", names.to_yaml)

      index_next_player, next_player = next_player(names)
      Discard.new("next_player_discard").present_players(next_player)

    elsif url == "http://rftg/next_player_discard" && method == "POST"
      names = YAML.load(File.read("names.yml"))
      index_next_player, next_player = next_player(names)

      new_names = names.map.with_index do |x, i|
        i == index_next_player ? x.merge("status" => :discarded) : x
      end
      File.write("names.yml", new_names.to_yaml)

      action = if names.map{ |x| x["status"] }.count(:not_discarded) == 1
                 "choose_phases"
               else
                 "next_player_discard"
               end

      Discard.new(action).discard_cards(next_player)

    elsif url == "http://rftg/choose_phases" && method == "POST"

    else
      Welcome.display
    end
  end
end

def next_player(names)
  status = names.map{ |x| x["status"] }
  index_next_player = status.index(:not_discarded)
  next_player = names[index_next_player]["name"]
  [index_next_player, next_player]
end

