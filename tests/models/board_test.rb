require 'minitest/autorun'
require_relative '../../models/board.rb'

class BoardTest < Minitest::Test
  CARDS = (1..6).to_a.map do |x|
    Model::Card.new(name: "card: #{x}", id: x,  cost: x, victory_points: x)
  end
  PLAYERS = [
    Model::Player.new("player 1", Model::Hand.empty, Model::Tableau.empty),
    Model::Player.new("player 2", Model::Hand.new(CARDS), Model::Tableau.empty)]
  STACK = Model::Stack.new([])
  GRAVEYARD = Model::Graveyard.empty

  def test_initialize_game
    players_names = ["boule", "bill"]
    board = Model::Board.initialize_game(players_names)

    assert_equal("Boule", board.players[0].name)
    assert_equal("Bill", board.players[1].name)
  end

  def test_next_player_to_discard
    board = Model::Board.new(PLAYERS, STACK, GRAVEYARD)
    next_player = board.next_player_to_discard

    assert_equal("player 2", next_player.name)
    assert_equal([], next_player.tableau.cards)
  end
end
