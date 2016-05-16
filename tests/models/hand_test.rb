require 'minitest/autorun'
require_relative '../../models/card.rb'
require_relative '../../models/hand.rb'

class HandTest < Minitest::Unit::TestCase
  def test_add_cards
    card1 = Model::Card.new(name: "card test 1", id: 1, cost: 0, victory_points: 2)
    card2 = Model::Card.new(name: "card test 2", id: 2, cost: 0, victory_points: 4)
    card3 = Model::Card.new(name: "card test 3", id: 3, cost: 0, victory_points: 6)
    card4 = Model::Card.new(name: "card test 4", id: 4, cost: 0, victory_points: 6)

    cards = [card1, card2, card3]
    extra = [card4]

    hand = Model::Hand.new(cards)

    new_hand = hand.add_cards(extra)
    assert_equal [card1, card2, card3, card4], new_hand.cards
  end

  def test_remove_cards
    card1 = Model::Card.new(name: "card test 1", id: 1, cost: 0, victory_points: 2)
    card2 = Model::Card.new(name: "card test 2", id: 2, cost: 0, victory_points: 4)
    card3 = Model::Card.new(name: "card test 3", id: 3, cost: 0, victory_points: 6)
    card4 = Model::Card.new(name: "card test 4", id: 4, cost: 0, victory_points: 6)

    cards = [card1, card2, card3, card4]

    hand = Model::Hand.new(cards)

    new_hand, discarded_cards = hand.remove_cards(1, 2)
    assert_equal [card1, card2], discarded_cards
    assert_equal [card3, card4], new_hand.cards
  end
end
