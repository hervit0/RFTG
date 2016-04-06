require_relative 'card.rb'

class Stack
  attr_reader :cards
  def initialize(cards:)
    @cards = cards
  end

  def fill(cards:)
    copies = cards.map{ |x| x["quantity"] }
    cards_with_copies = copies.zip(cards).flat_map{ |x, y| Array.new(x, y) }

    Stack.new(cards:
      cards_with_copies.map.with_index do |item, ind|
        Card.new(item["name"], ind, item["cost"], item["victory_points"])
      end
    )
  end

  def draw(number)
    drawn_cards = @cards.sample(number)
    identities_drawn = drawn_cards.map{ |x| x.id }
    new_stack = @cards.reject{|x| identities_drawn.include?(x.id)}

    [Stack.new(new_stack), drawn_cards]
  end
  #feature: add graveyard if the stack is empty
end
