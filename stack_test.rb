require 'minitest/autorun'
require_relative 'stack.rb'

class StackTest < Minitest::Test
  def test_draw
    stack = Stack.new([1, 2, 3])
    assert_equal [1, 2, 3], stack.draw(0).cards
    assert_equal [], stack.draw(3).cards
  end
end
