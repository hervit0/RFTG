require 'minitest/autorun'
require_relative '../../models/stack.rb'
require_relative '../../models/card.rb'

class StackTest < Minitest::Unit::TestCase
  NUMBER = 4

  def self.cards_set
    (1..NUMBER).to_a.map do |x|
      Model::Card.new(
        name: "card #{x}",
        id: x,
        cost: x,
        victory_points: x
      )
    end
  end

  def test_from_cards
    cards = (1..4).to_a.map do |x|
      {
        'name' => "card #{x}",
        'id' => x,
        'quantity' => x,
        'cost' => x,
        'victory_points' => x
      }
    end
    stack = Model::Stack.from_cards(cards)

    assert_equal 'card 3', stack.cards[3].name
    assert_equal 3, stack.cards[3].cost
    assert_equal 3, stack.cards[3].victory_points
    assert_equal 2, stack.cards.map(&:name).count('card 2')
    assert_equal 10, stack.cards.length
  end

  def test_draw
    cards = StackTest.cards_set
    stack = Model::Stack.new(cards)

    new_stack1, _drawn_cards1 = stack.draw(0)
    new_stack2, _drawn_cards2 = stack.draw(NUMBER)
    _new_stack3, drawn_cards3 = stack.draw((1..NUMBER).to_a.sample)

    assert_equal cards, new_stack1.cards
    assert_equal [], new_stack2.cards
    drawn_cards3.map(&:id).each do |id|
      assert_includes (1..NUMBER).to_a, id
    end
  end
end
