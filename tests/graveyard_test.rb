require 'minitest/autorun'
require_relative '../card.rb'
require_relative '../graveyard.rb'

class GraveyardTest < Minitest::Test
  def test_add_cards
    card1 = Card.new(name: "card test 1", id: 1, cost: 0, victory_points: 2)
    card2 = Card.new(name: "card test 2", id: 2, cost: 0, victory_points: 4)
    card3 = Card.new(name: "card test 3", id: 3, cost: 0, victory_points: 6)
    cards  = [card1, card2]
    extra_cards = [card3]

    graveyard = Graveyard.new(cards)
    new_graveyard = graveyard.add_cards(extra_cards)

    assert_equal [card1, card2, card3], new_graveyard.cards
  end
end