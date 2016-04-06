require 'minitest/autorun'
require_relative 'board.rb'

class BoardTest < Minitest::Test
  def test_fill_stack
    card1 = {"name"=>"Card 1", "quantity"=>1, "cost"=>0, "victory_points"=>1 }
    card2 = {"name"=>"Card 2", "quantity"=>2, "cost"=>0, "victory_points"=>1 }
    card3 = {"name"=>"Card 3", "quantity"=>1, "cost"=>0, "victory_points"=>1 }
    cards = [card1, card2, card3]

    stack = Stack.new([])
    board = Board.new(stack)
    new_board = board.fill_stack(cards)

    assert_equal 4, new_board.stack.cards.length
    assert_equal Board, new_board.class
    assert_equal Stack, new_board.stack.class
    assert_equal Card, new_board.stack.cards[0].class
  end
end

#card1 = Card.new(name: "Card 1", id: 1, cost: 0, victory_points: 2)
#card2 = Card.new(name: "Card 2", id: 2, cost: 2, victory_points: 3)
#card3 = Card.new(name: "Card 3", id: 3, cost: 3, victory_points: 5)
