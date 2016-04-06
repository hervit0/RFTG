require 'minitest/autorun'
require_relative 'player.rb'

class PlayerTest < Minitest::Test
  def test_draw
    card1 = Card.new(name: "card test 1", id: 1, cost: 0, victory_points: 2)
    card2 = Card.new(name: "card test 2", id: 2, cost: 0, victory_points: 4)
    card3 = Card.new(name: "card test 3", id: 3, cost: 0, victory_points: 6)
    cards  = [card1, card2, card3]

    stack = Stack.new(cards)
    hand = Hand.new([])
    tableau = Tableau.new([])
    player = Player.new("player", hand, tableau)

    new_player, new_stack = player.draw(3, stack)
    cards_hand = new_player.hand.cards
    organized_hand = (1..3).map{|x| cards_hand.reject{|y| y.id != x} }.flatten

    assert_equal cards, organized_hand
  end

  def test_victory_points
    card1 = Card.new(name: "card test 1", id: 1, cost: 0, victory_points: 2)
    card2 = Card.new(name: "card test 2", id: 2, cost: 0, victory_points: 4)
    card3 = Card.new(name: "card test 3", id: 3, cost: 0, victory_points: 6)
    cards = [card1, card2, card3]

    hand = Hand.new([])
    tableau = Tableau.new(cards)
    stack = Stack.new([])
    player = Player.new("player", hand, tableau)

    assert_equal 12, player.victory_points
  end

  def test_choose_first_cards
    hand = Hand.new([1, 2, 3])
    tableau = Tableau.new([])
    graveyard = Graveyard.new([7])
    player = Player.new("player", hand, tableau)

    puts "FOR TEST, PRESS 1 THEN 2"
    new_player, new_graveyard = player.choose_first_cards(graveyard)

    assert_equal [3], new_player.hand.cards
    assert_equal [7, 1, 2], new_graveyard.cards
  end
end
