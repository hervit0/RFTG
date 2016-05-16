require 'minitest/autorun'
require_relative '../../models/card.rb'
require_relative '../../models/tableau.rb'

class TableauTest < Minitest::Unit::TestCase
  def test_victory_points
    card1 = Model::Card.new(name: 'card test 1', id: 1, cost: 0, victory_points: 2)
    card2 = Model::Card.new(name: 'card test 2', id: 2, cost: 0, victory_points: 4)
    card3 = Model::Card.new(name: 'card test 3', id: 3, cost: 0, victory_points: 6)
    cards = [card1, card2, card3]

    tableau = Model::Tableau.new(cards)

    assert_equal 12, tableau.victory_points
  end
end
