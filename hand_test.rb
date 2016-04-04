require 'minitest/autorun'
require_relative 'hand.rb'
require_relative 'stack.rb'

class HandTest < Minitest::Test
  def test_draw_cards
    cards = []
    stack = Stack.new([1, 2, 3, 4, 5])

    hand = Hand.new(cards, stack)

    hand_new = hand.draw_cards(1)
    assert_equal [1, 2, 3, 4, 5], hand_new.stack.cards + hand_new.cards
  end

  def test_remove_cards
    cards = [1, 2, 3, 4, 5, 6]
    stack = []

    hand = Hand.new(cards, stack)
    new_hand = hand.remove_cards(1, 2)

    assert_equal [3, 4, 5, 6], new_hand.cards
  end
end
