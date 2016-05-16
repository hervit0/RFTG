require 'minitest/autorun'
require_relative '../../models/card.rb'
require_relative '../../models/graveyard.rb'

class GraveyardTest < Minitest::Unit::TestCase
  def test_add_cards
    card1 = Model::Card.new(name: "card test 1", id: 1, cost: 0, victory_points: 2)
    card2 = Model::Card.new(name: "card test 2", id: 2, cost: 0, victory_points: 4)
    card3 = Model::Card.new(name: "card test 3", id: 3, cost: 0, victory_points: 6)
    cards  = [card1, card2]
    extra_cards = [card3]

    graveyard = Model::Graveyard.new(cards)
    new_graveyard = graveyard.add_cards(extra_cards)

    assert_equal [card1, card2, card3], new_graveyard.cards
  end
end
