require 'minitest/autorun'
require 'rack'
require_relative '../../services/state.rb'
require_relative '../../models/board.rb'
require_relative '../../errors.rb'

class StateTest < Minitest::Unit::TestCase
  CARDS = (1..6).to_a.map do |x|
    Model::Card.new(name: "card: #{x}", id: x, cost: x, victory_points: x)
  end
  PLAYERS = [
    Model::Player.new('player 1', Model::Hand.empty, Model::Tableau.empty),
    Model::Player.new('player 2', Model::Hand.new(CARDS), Model::Tableau.empty)
  ].freeze
  STACK = Model::Stack.new([])
  GRAVEYARD = Model::Graveyard.empty
  STATE = Service::State.new(PLAYERS, STACK, GRAVEYARD)

  def test_initialize_game
    names = %w(boule bill)
    state_marshalled = Service::State.initialize_game(names)
    state = Service::State.unmarshal(state_marshalled)

    assert_equal('Boule', state.players[0].name)
    assert_equal('Bill', state.players[1].name)
  end

  def test_players_number
    players_number = '2'
    state = Service::State.marshal_players_number(players_number)

    assert_equal(2, Service::State.players_number(state))
  end

  def test_marshal_unmarshal
    state_marshalled = STATE.marshal
    state_test = Service::State.unmarshal(state_marshalled)
    player1, player2 = state_test.players

    assert_equal('player 1', player1.name)
    assert_equal('player 2', player2.name)
    assert_equal([], player1.hand.cards)

    hand_player2 = player2.hand
    assert_equal('card: 1', hand_player2.cards[0].name)
    assert_equal(2, hand_player2.cards[1].id)
    assert_equal(3, hand_player2.cards[2].cost)
    assert_equal(4, hand_player2.cards[3].victory_points)

    assert_equal([], player1.tableau.cards)
    assert_equal([], player2.tableau.cards)
    assert_equal([], state_test.stack.cards)
    assert_equal([], state_test.graveyard.cards)
  end

  def test_cards_marshal_from
    cards_test = Service::Cards.marshal_from(CARDS)

    assert_equal('card: 1', cards_test[0][Service::NAME])
    assert_equal(2, cards_test[1][Service::ID])
    assert_equal(3, cards_test[2][Service::COST])
    assert_equal(4, cards_test[3][Service::VICTORY_POINTS])
  end

  def test_cards_unmarshal_from
    state_test = STATE.marshal
    hand_of_player2 = state_test[Service::PLAYERS][1][Service::HAND]
    cards_test = Service::Cards.unmarshal_from(hand_of_player2)

    assert_equal('card: 1', cards_test[0].name)
    assert_equal(2, cards_test[1].id)
    assert_equal(3, cards_test[2].cost)
    assert_equal(4, cards_test[3].victory_points)
  end

  def test_players_marshal_from
    players_test = Service::Players.marshal_from(PLAYERS)

    assert_equal('player 1', players_test[0][Service::NAME])
    assert_equal([], players_test[0][Service::HAND])
    assert_equal([], players_test[1][Service::TABLEAU])
  end

  def test_players_unmarshal_from
    state_test = STATE.marshal
    players_test = Service::Players.unmarshal_from(state_test[Service::PLAYERS])

    assert_equal('player 1', players_test[0].name)
    assert_equal([], players_test[1].tableau.cards)
  end
end
