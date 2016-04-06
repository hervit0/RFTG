require 'minitest/autorun'
require_relative 'board.rb'

class BoardTest < Minitest::Test
  def test_board_creation
    card1 = {"name"=>"Card 1", "quantity"=>1, "cost"=>0, "victory_points"=>1 }
    card2 = {"name"=>"Card 2", "quantity"=>2, "cost"=>0, "victory_points"=>1 }
    card3 = {"name"=>"Card 3", "quantity"=>1, "cost"=>0, "victory_points"=>1 }
    cards = [card1, card2, card3]

    board = Board.new(Stack.from_cards(cards))

    assert_equal 4, board.stack.cards.length
    assert_equal Board, board.class
    assert_equal Stack, board.stack.class
    board.stack.cards.map do |x|
      assert_equal Card, x.class
    end
  end
end

#card1 = Card.new(name: "Card 1", id: 1, cost: 0, victory_points: 2)
#card2 = Card.new(name: "Card 2", id: 2, cost: 2, victory_points: 3)
#card3 = Card.new(name: "Card 3", id: 3, cost: 3, victory_points: 5)
