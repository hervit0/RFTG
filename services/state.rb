require 'yaml'
require_relative '../models/player.rb'
require_relative '../models/stack.rb'
require_relative '../models/hand.rb'
require_relative '../models/card.rb'
require_relative '../models/graveyard.rb'
require_relative '../models/tableau.rb'

class State
  attr_reader :id, :players, :stack, :graveyard
  def initialize(id, players, stack, graveyard)
    @id = id
    @players = players
    @stack = stack
    @graveyard = graveyard
  end

  def record
    state = {
      "id" => @id,
      "players" => detail_players(@players),
      "stack" => detail_cards(@stack.cards),
      "graveyard" => detail_cards(@graveyard.cards)
    }
    File.write("#{@id}.yml", state.to_yaml)
  end

  def self.watch(id)
    state = YAML.load(File.read("#{id}.yml"))
    id = state["id"]
    players = create_players(state["players"])
    stack = Stack.new(create_cards(state["stack"]))
    graveyard = Graveyard.new(create_cards(state["graveyard"]))
    State.new(id, players, stack, graveyard)
  end
end

def detail_players(players)
  players.map do |x|
    {"name" => x.name,
     "hand" => detail_cards(x.hand.cards),
     "tableau" => detail_cards(x.tableau.cards)}
  end
end

def detail_cards(cards)
  cards.map do |x|
    {"name" => x.name,
     "id" => x.id,
     "cost" => x.cost,
     "victory_points" => x.victory_points
    }
  end
end

def create_players(players)
  players.map do |x|
    Player.new(
      x["name"],
      Hand.new(create_cards(x["hand"])),
      Tableau.new(create_cards(x["tableau"]))
    )
  end
end

def create_cards(cards)
  cards == [] ? [] :
  cards.map do |x|
    Card.new(
      name: x["name"],
      id: x["id"],
      cost: x["cost"],
      victory_points: x["victory_points"]
    )
  end
end
