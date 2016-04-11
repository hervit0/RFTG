require 'minitest/autorun'
require_relative '../hand.rb'

class CardTest < Minitest::Test
  def test_display
    card = Card.new(name: "Name", id: "id", cost: 0, victory_points: 1)
    assert_equal card.display, "Name - Cost: 0, Points: 1"
  end
end

