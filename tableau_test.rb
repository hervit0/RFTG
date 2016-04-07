require 'minitest/autorun'
require_relative 'card.rb'
require_relative 'tableau.rb'

class TableauTest < Minitest::Test
  def test_victory_points
    card1 = Card.new(name: "card test 1", id: 1, cost: 0, victory_points: 2)
    card2 = Card.new(name: "card test 2", id: 2, cost: 0, victory_points: 4)
    card3 = Card.new(name: "card test 3", id: 3, cost: 0, victory_points: 6)
    cards = [card1, card2, card3]

    tableau = Tableau.new(cards)

    assert_equal 12, tableau.victory_points
  end
end
