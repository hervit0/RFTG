require 'minitest/autorun'
require_relative 'stack.rb'

class StackTest < Minitest::Test
  def test_draw_cards
    stack = Stack.new([1, 2, 3])
    assert_equal [1, 2, 3], stack.draw_cards(0).cards
    assert_equal [], stack.draw_cards(3).cards
  end
end
