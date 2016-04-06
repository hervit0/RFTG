require_relative 'card.rb'

class Stack
  attr_reader :cards
  def initialize(cards)
    @cards = cards
  end

  def draw(number)
    drawn_cards = @cards.sample(number)
    identities_drawn = drawn_cards.map{ |x| x.id }
    new_stack = @cards.reject{|x| identities_drawn.include?(x.id)}

    [Stack.new(new_stack), drawn_cards]
  end
  #feature: add graveyard if the stack is empty
end
