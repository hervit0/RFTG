require 'minitest/autorun'
require_relative '../../models/hand.rb'

class CardTest < Minitest::Unit::TestCase
  def test_display
    card = Model::Card.new(name: "Name", id: "id", cost: 0, victory_points: 1)
    assert_equal card.display, "Name - Cost: 0, Points: 1"
  end
end

