require 'minitest/autorun'
require_relative 'card.rb'
require_relative 'hand.rb'

class HandTest < Minitest::Test
  def test_add_cards
    card1 = Card.new(name: "card test 1", id: 1, cost: 0, victory_points: 2)
    card2 = Card.new(name: "card test 2", id: 2, cost: 0, victory_points: 4)
    card3 = Card.new(name: "card test 3", id: 3, cost: 0, victory_points: 6)
    card4 = Card.new(name: "card test 4", id: 4, cost: 0, victory_points: 6)

    cards = [card1, card2, card3]
    extra = [card4]

    hand = Hand.new(cards)

    new_hand = hand.add_cards(extra)
    assert_equal [card1, card2, card3, card4], new_hand.cards
  end

  def test_remove_cards
    card1 = Card.new(name: "card test 1", id: 1, cost: 0, victory_points: 2)
    card2 = Card.new(name: "card test 2", id: 2, cost: 0, victory_points: 4)
    card3 = Card.new(name: "card test 3", id: 3, cost: 0, victory_points: 6)
    card4 = Card.new(name: "card test 4", id: 4, cost: 0, victory_points: 6)

    cards = [card1, card2, card3, card4]

    hand = Hand.new(cards)

    new_hand, discarded_cards = hand.remove_cards(1, 2)
    assert_equal [card1, card2], discarded_cards
    assert_equal [card3, card4], new_hand.cards
  end
end
