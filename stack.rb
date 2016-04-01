require_relative 'card.rb'

class Stack
  attr_reader :cards
  def initialize(cards)
    @cards = cards
  end
  #feature: add graveyard if the stack is empty
end
