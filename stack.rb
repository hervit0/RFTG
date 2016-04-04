require_relative 'card.rb'

class Stack
  attr_reader :cards
  def initialize(cards)
    @cards = cards
  end

  def draw_cards(number)
    drawn_cards = @cards.sample(number)
    Stack.new(@cards - drawn_cards)
  end
  #feature: add graveyard if the stack is empty
end
