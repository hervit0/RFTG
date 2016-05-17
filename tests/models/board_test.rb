require 'minitest/autorun'
require_relative '../../models/board.rb'

class BoardTest < Minitest::Unit::TestCase
  CARDS = (1..6).to_a.map do |x|
    Model::Card.new(name: "card: #{x}", id: x, cost: x, victory_points: x)
  end
  PLAYERS = [
    Model::Player.new('player 1', Model::Hand.empty, Model::Tableau.empty),
    Model::Player.new('player 2', Model::Hand.new(CARDS), Model::Tableau.empty)
  ].freeze
  STACK = Model::Stack.new([])
  GRAVEYARD = Model::Graveyard.empty
  BOARD = Model::Board.new(PLAYERS, STACK, GRAVEYARD)

  def test_initialize_game
    players_names = %w(boule bill)
    board = Model::Board.initialize_game(players_names)

    assert_equal('Boule', board.players[0].name)
    assert_equal('Bill', board.players[1].name)
  end

  def test_count_players_havent_discard
    assert_equal(1, BOARD.count_players_havent_discard)
  end

  def test_next_player_to_discard
    next_player = BOARD.next_player_to_discard

    assert_equal('player 2', next_player.name)
    assert_equal([], next_player.tableau.cards)
  end

  def test_make_player_discard
    new_board = BOARD.make_player_discard(1, 2)
    player_2_hand = new_board.players[1].hand.cards.map(&:id)

    assert_equal([3, 4, 5, 6], player_2_hand)
  end
end
