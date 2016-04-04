require 'minitest/autorun'
require_relative 'player.rb'

class PlayerTest < Minitest::Test
  def test_draw
    hand = Hand.new([])
    tableau = Tableau.new([])
    stack = Stack.new([1, 2, 3, 4])
    player = Player.new(hand, tableau, stack)

    assert_equal [1, 2, 3, 4], player.draw(4).hand.cards.sort
  end

  def test_victory_points
    card1 = Card.new("card test 1", 0, 2)
    card2 = Card.new("card test 2", 0, 4)
    card3 = Card.new("card test 3", 0, 6)
    set = [card1, card2, card3]

    hand = Hand.new([])
    tableau = Tableau.new(set)
    stack = Stack.new([])
    player = Player.new(hand, tableau, stack)

    assert_equal 12, player.victory_points
  end
end
