require 'minitest/autorun'
require_relative '../../models/card.rb'
require_relative '../../models/graveyard.rb'

class GraveyardTest < Minitest::Unit::TestCase
  def self.cards_set
    (1..4).to_a.map do |x|
      Model::Card.new(
        name: "card test #{x}",
        id: x,
        cost: 0,
        victory_points: x * 2
      )
    end
  end

  def test_add_cards
    set = GraveyardTest.cards_set
    cards = set.take(3)
    extra_card = set.last

    graveyard = Model::Graveyard.new(cards)
    new_graveyard = graveyard.add_cards([extra_card])

    assert_equal set.map(&:id), new_graveyard.cards.map(&:id)
  end
end
