require_relative 'card.rb'

module Model
  class Stack
    attr_reader :cards
    def initialize(cards)
      @cards = cards
    end

    def self.from_cards(cards)
      copies = cards.map { |x| x['quantity'] }
      cards_with_copies = copies.zip(cards).flat_map { |x, y| Array.new(x, y) }

      first_cards = cards_with_copies.map.with_index do |x, i|
        Model::Card.new(
          name: x['name'],
          id: i,
          cost: x['cost'],
          victory_points: x['victory_points']
        )
      end

      Model::Stack.new(first_cards)
    end

    def draw(number)
      drawn_cards = @cards.sample(number)
      identities_drawn = drawn_cards.map(&:id)
      new_stack = @cards.reject { |x| identities_drawn.include?(x.id) }

      [Model::Stack.new(new_stack), drawn_cards]
    end
  end
end
