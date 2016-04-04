require 'minitest/autorun'
require_relative 'hand.rb'

class HandTest < Minitest::Test
  def test_add_cards
    cards = [1, 2, 3]
    extra = [4]
    hand = Hand.new(cards)

    new_hand = hand.add_cards(extra)
    assert_equal [1, 2, 3, 4], new_hand.cards
  end

  def test_remove_cards
    cards = [1, 2, 3, 4, 5, 6]
    hand = Hand.new(cards)

    new_hand = hand.remove_cards(1, 2)
    assert_equal [3, 4, 5, 6], new_hand.cards
  end
end
