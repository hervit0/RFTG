require_relative 'RFTG_board.rb'
require 'minitest/autorun'

class TestBoard < Minitest::Test

  def test_cards_sum_after_distribution
    (PLAYERS_NUMBER_MAX - 1).times do |x| 
      distribution = distribute_cards(STACK, x)
      cards_for_players = distribution[0].flatten
      cards_left_in_stack = distribution[1]

      assert_equal (cards_for_players + cards_left_in_stack).length, STACK.length
      assert_equal (STACK - cards_left_in_stack - cards_for_players), [] 
    end
  end

end
