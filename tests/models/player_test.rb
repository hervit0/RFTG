require 'minitest/autorun'
require_relative '../../models/player.rb'
require_relative '../../models/card.rb'
require_relative '../../models/stack.rb'
require_relative '../../models/graveyard.rb'

class PlayerTest < Minitest::Test
  def test_draw
    card1 = Model::Card.new(name: "card test 1", id: 1, cost: 0, victory_points: 2)
    card2 = Model::Card.new(name: "card test 2", id: 2, cost: 0, victory_points: 4)
    card3 = Model::Card.new(name: "card test 3", id: 3, cost: 0, victory_points: 6)
    cards  = [card1, card2, card3]

    stack = Model::Stack.new(cards)
    hand = Model::Hand.new([])
    tableau = Model::Tableau.new([])
    player = Model::Player.new("player", hand, tableau)

    new_player, new_stack = player.draw(3, stack)
    cards_hand = new_player.hand.cards
    organized_hand = (1..3).map{|x| cards_hand.reject{|y| y.id != x} }.flatten

    assert_equal cards, organized_hand
  end

  def test_choose_first_cards
    hand = Model::Hand.new([1, 2, 3])
    tableau = Model::Tableau.new([])
    graveyard = Model::Graveyard.new([7])
    player = Model::Player.new("player", hand, tableau)

    new_player, new_graveyard = player.choose_first_cards(graveyard, 1, 2)

    assert_equal [3], new_player.hand.cards
    assert_equal [7, 1, 2], new_graveyard.cards
  end
end
