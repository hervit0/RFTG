require 'minitest/autorun'
require_relative 'board.rb'

class BoardTest < Minitest::Test
  def test_stack
    board = Board.new(Stack.new([]))
    new_board = board.fill_stack(CARDS)

    assert_equal 50, new_board.stack.cards.length
    assert_equal Board, new_board.class
    assert_equal Stack, new_board.stack.class
    assert_equal Card, new_board.stack.cards[0].class
  end
end
