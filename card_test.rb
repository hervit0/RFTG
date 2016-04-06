require 'minitest/autorun'
require_relative 'hand.rb'

class CardTest < Minitest::Test
  def test_display
    card = Card.new("Name", "id", 0, 1)
    assert_equal card.display, "Name - Cost: 0, Points: 1"
  end
end

