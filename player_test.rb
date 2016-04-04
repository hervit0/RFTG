require 'minitest/autorun'
require_relative 'player.rb'

class PlayerTest < Minitest::Test
  def test_victory_points
    card1 = Card.new("card test 1", 0, 2)
    card2 = Card.new("card test 2", 0, 4)
    card3 = Card.new("card test 3", 0, 6)
    set = [card1, card2, card3]

    hand = Hand.new([])
    tableau = Tableau.new(set)
    player = Player.new(hand, tableau)

    assert_equal player.victory_points, 12
  end
end
