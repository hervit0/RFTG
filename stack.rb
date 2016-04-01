require_relative 'card.rb'

class Stack
  def initialize(cards_stack)
    @cards_stack = cards_stack
  end

  def show_cards_stack
    p @cards_stack
  end

  #feature: add graveyard if the stack is empty
end
