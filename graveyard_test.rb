require_relative 'graveyard.rb'
require 'minitest/autorun'

class GraveyardTest < Minitest::Test
  def test_add_cards
    graveyard = Graveyard.new([1, 2, 3])
    extra_cards = [4, 5]
    new_graveyard = graveyard.add_cards(extra_cards)

    assert_equal [1, 2, 3, 4, 5], new_graveyard.cards
  end
end
