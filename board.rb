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

  def fill_stack(cards)
    new_stack = @stack.fill(cards)
    Board.new(new_stack)
  end
end
