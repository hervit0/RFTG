require 'minitest/autorun'
require_relative '../../models/card.rb'
require_relative '../../models/hand.rb'

class HandTest < Minitest::Unit::TestCase
  def self.cards_set
    (1..4).to_a.map do |x|
      Model::Card.new(
        name: "card test #{x}",
        id: x,
        cost: 0,
        victory_points: x*2
      )
    end
  end

  def test_add_cards
    cards = HandTest.cards_set.take(3)
    extra_card = [HandTest.cards_set.last]

    hand = Model::Hand.new(cards)

    new_hand = hand.add_cards(extra_card)
    assert_equal HandTest.cards_set.map(&:id), new_hand.cards.map(&:id)
  end

  def test_remove_cards
    cards = HandTest.cards_set

    hand = Model::Hand.new(cards)

    new_hand, discarded_cards = hand.remove_cards(1, 2)
    assert_equal HandTest.cards_set.take(2).map(&:id), discarded_cards.map(&:id)
    assert_equal HandTest.cards_set.drop(2).map(&:id), new_hand.cards.map(&:id)
  end
end
