require 'minitest/autorun'
require_relative 'player.rb'

class PlayerTest < Minitest::Test
  def test_draw
    stack = Stack.new([1, 2, 3, 4])
    hand = Hand.new([], stack)
    tableau = Tableau.new([])

    player = Player.new(hand, tableau)
    assert_equal [1, 2, 3, 4], player.draw(4).cards.sort
  end

  def test_victory_points
    card1 = Card.new("card test 1", 0, 2)
    card2 = Card.new("card test 2", 0, 4)
    card3 = Card.new("card test 3", 0, 6)
    set = [card1, card2, card3]

    stack = Stack.new([])
    hand = Hand.new([], stack)
    tableau = Tableau.new(set)
    player = Player.new(hand, tableau)

    assert_equal 12, player.victory_points
  end
end
