require 'minitest/autorun'
require_relative 'player.rb'

class PlayerTest < Minitest::Test
  def test_give_name
    puts "For test, write toto."
    new_player = Player.new([], [])
    new_player.give_name!
    assert_equal "toto", new_player.name
  end

  def test_draw
    hand = Hand.new([])
    tableau = Tableau.new([])
    stack = Stack.new([1, 2, 3, 4])
    player = Player.new(hand, tableau)

    new_player, new_stack = player.draw(4, stack)

    assert_equal [1, 2, 3, 4], new_player.hand.cards.sort
  end

  def test_victory_points
    card1 = Card.new("card test 1", 0, 2)
    card2 = Card.new("card test 2", 0, 4)
    card3 = Card.new("card test 3", 0, 6)
    set = [card1, card2, card3]

    hand = Hand.new([])
    tableau = Tableau.new(set)
    stack = Stack.new([])
    player = Player.new(hand, tableau)

    assert_equal 12, player.victory_points
  end

  def test_choose_first_cards
    hand = Hand.new([1, 2, 3])
    tableau = Tableau.new([])
    graveyard = Graveyard.new([7])
    player = Player.new(hand, tableau)

    puts "For test, press 1 then 2"
    new_player, new_graveyard = player.choose_first_cards(graveyard)

    assert_equal [3], new_player.hand.cards
    assert_equal [7, 1, 2], new_graveyard.cards
  end
end
