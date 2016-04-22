require 'yaml'
require_relative 'state.rb'
require_relative '../models/player.rb'
require_relative '../models/stack.rb'
require_relative '../models/hand.rb'
require_relative '../models/graveyard.rb'

CARDS = YAML.load(File.read("models/cards.yml"))

class Players
  def self.number(request)
    request.POST.values.first.to_i
  end

  def self.names(request)
    id = request.cookies["session"]
    stack = Stack.from_cards(CARDS)
    graveyard = Graveyard.new([])
    players = request.POST.to_a.map do |x|
      Player.new(x[1], Hand.new([]), []).draw(6, stack).first
    end
    p players
    State.new(id, players, stack, graveyard).record
    p State.watch(id).id
  end

  def self.present
    player_index, player_name = next_player
  end

  def self.discard
    player_index, player_name, names = next_player
    new_names = names.map.with_index do |x, i|
      i == player_index ? x.merge("status" => :discarded) : x
    end
    File.write("names.yml", new_names.to_yaml)

    action = if names.map{ |x| x["status"] }.count(:not_discarded) == 1
               "choose_phases"
             else
               "present_player"
             end
    [action, player_name]
  end
end

def next_player
  names = YAML.load(File.read("names.yml"))
  status = names.map{ |x| x["status"] }
  player_index = status.index(:not_discarded)
  player_name = names[player_index]["name"]
  [player_index, player_name, names]
end

