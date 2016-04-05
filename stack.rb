require_relative 'card.rb'

class Stack
  attr_reader :cards
  def initialize(cards)
    @cards = cards
  end

  def draw(number)
    drawn_cards = @cards.sample(number)
    cards_uniq = @cards.uniq.sort
    cards_numbers = cards_uniq.map{ |x| @cards.count(x) - drawn_cards.count(x) }
    new_stack = cards_uniq.zip(cards_numbers).flat_map{ |x, y| Array.new(y, x) }
    [Stack.new(new_stack), drawn_cards]
  end
  #feature: add graveyard if the stack is empty
end
