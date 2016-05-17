require 'minitest/autorun'
require_relative '../../models/card.rb'
require_relative '../../models/tableau.rb'

class TableauTest < Minitest::Unit::TestCase
  def self.cards_set
    (1..4).to_a.map do |x|
      Model::Card.new(
        name: "card test #{x}",
        id: x,
        cost: 0,
        victory_points: x * 2
      )
    end
  end

  def test_victory_points
    cards = TableauTest.cards_set
    tableau = Model::Tableau.new(cards)

    assert_equal 20, tableau.victory_points
  end
end
