require 'minitest/autorun'
require_relative 'stack.rb'

class StackTest < Minitest::Test
  def test_draw
    card1 = Card.new("card 1", 1, 1, 1)
    card2 = Card.new("card 2", 2, 1, 1)
    card3 = Card.new("card 3", 3, 1, 1)
    card4 = Card.new("card 4", 4, 1, 1)
    set = [card1, card2, card3, card4]

    stack = Stack.new(set)

    new_stack1, drawn_cards1 = stack.draw(0)
    assert_equal [card1, card2, card3, card4], new_stack1.cards

    new_stack2, drawn_cards2 = stack.draw(4)
    assert_equal [], new_stack2.cards
  end
end
