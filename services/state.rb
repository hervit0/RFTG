require 'yaml'
require_relative '../models/player.rb'
require_relative '../models/stack.rb'
require_relative '../models/hand.rb'
require_relative '../models/graveyard.rb'

class State
  attr_reader :id, :players, :stack, :graveyard
  def initialize(id, players, stack, graveyard)
    @id = id
    @players = players
    @stack = stack
    @graveyard = graveyard
  end

  def record
    content = {
      "id" => @id,
      "players" => @players.map do |x|
        {"name" => x.name,
         "hand" => x.hand,
         "tableau" => x.tableau}
      end,
      "stack" => @stack.cards,
      "graveyard" => @graveyard.cards
    }
    File.write("#{@id}.yml", content.to_yaml)
  end

  def self.watch(id)
    state = YAML.load(File.read("#{id}.yml"))
    p state
    content = state.values
    State.new(*content)
  end
end
