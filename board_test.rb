require 'minitest/autorun'
require_relative 'board.rb'

class BoardTest < Minitest::Test
  def test_stack
    board = Board.new(stack: Stack.new(cards: []))
    new_board = board.fill_stack(cards: CARDS)
    assert_equal 50, new_board.stack.cards.length
  end
end
