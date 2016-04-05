require 'minitest/autorun'
require_relative 'stack.rb'

class StackTest < Minitest::Test
  def test_draw
    stack = Stack.new([1, 2, 3, 1])

    new_stack1, drawn_cards1 = stack.draw(0)
    assert_equal [1, 1, 2, 3], new_stack1.cards

    new_stack2, drawn_cards2 = stack.draw(4)
    assert_equal [], new_stack2.cards
  end
end
