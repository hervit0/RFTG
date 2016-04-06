require 'yaml'
require_relative 'card.rb'
require_relative 'stack.rb'
require_relative 'graveyard.rb'
require_relative 'hand.rb'
require_relative 'player.rb'
require_relative 'tableau.rb'
require_relative 'phase.rb'

PLAYERS_NUMBER = 2
PLAYERS_NUMBER_MAX = 4
CARDS = YAML.load(File.read("cards.yml"))

class Board
  attr_reader :stack
  def initialize(stack)
    @stack = stack
  end
end

COPIES = CARDS.map{ |x| x["quantity"] }
CARDS_WITH_COPIES = COPIES.zip(CARDS).flat_map{ |x, y| Array.new(x, y) }

stack = Stack.new(
  CARDS_WITH_COPIES.map.with_index do |item, ind|
    Card.new(item["name"], ind, item["cost"], item["victory_points"])
  end
)
