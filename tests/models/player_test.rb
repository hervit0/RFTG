require 'minitest/autorun'
require_relative '../../models/player.rb'
require_relative '../../models/card.rb'
require_relative '../../models/stack.rb'
require_relative '../../models/graveyard.rb'

class PlayerTest < Minitest::Unit::TestCase
  def self.cards_set
    (1..3).to_a.map do |x|
      Model::Card.new(
        name: "card test #{x}",
        id: x,
        cost: 0,
        victory_points: x * 2
      )
    end
  end

  def test_draw
    cards = PlayerTest.cards_set
    stack = Model::Stack.new(cards)
    hand = Model::Hand.new([])
    tableau = Model::Tableau.new([])
    player = Model::Player.new('player', hand, tableau)

    new_player, _new_stack = player.draw(3, stack)
    cards_hand = new_player.hand.cards
    organized_hand = (1..3).flat_map do |x|
      cards_hand.reject { |y| y.id != x }
    end

    assert_equal cards, organized_hand
  end

  def test_choose_first_cards
    hand = Model::Hand.new([1, 2, 3])
    tableau = Model::Tableau.new([])
    graveyard = Model::Graveyard.new([7])
    player = Model::Player.new('player', hand, tableau)

    new_player, new_graveyard = player.choose_cards(graveyard, 1, 2)

    assert_equal [3], new_player.hand.cards
    assert_equal [7, 1, 2], new_graveyard.cards
  end
end
