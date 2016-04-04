require_relative 'card.rb'
require_relative 'stack.rb'

class Hand
  attr_reader :cards, :stack
  def initialize(cards, stack)
    @cards = cards
    @stack = stack
  end

  def display
    lines = @cards.map.with_index do |card, i|
      "Card #{i + 1}: #{card.display}"
    end
    lines.join("\n")
  end

  def draw_cards(number)
    drawn = @stack.cards.sample(number)
    stack_new = Stack.new(@stack.cards - drawn)
    Hand.new(@cards + drawn, stack_new)
  end

  def remove_cards(first, second)
    indexes = (0..@cards.length - 1).to_a - [first - 1] - [second - 1]
    new_cards = @cards.values_at(*indexes)
    Hand.new(new_cards, @stack)
  end
end
