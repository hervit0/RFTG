require 'minitest/autorun'
require 'rack'
require_relative '../../services/state.rb'

class StateTest < Minitest::Test
  ID = "id_test"
  CARDS = (1..6).to_a.map do |x|
    Model::Card.new(name: "card: #{x}", id: x,  cost: x, victory_points: x)
  end
  PLAYERS = [
    Model::Player.new("player 1", Model::Hand.empty, Model::Tableau.empty),
    Model::Player.new("player 2", Model::Hand.new(CARDS), Model::Tableau.empty)]
  STACK = Model::Stack.new([])
  GRAVEYARD = Model::Graveyard.empty
  STATE = Service::State.new(ID, PLAYERS, STACK, GRAVEYARD)

  def test_initialize_game
    player_name_1 = "boule"
    player_name_2 = "bill"
    env = Rack::MockRequest.env_for("", "HTTP_COOKIE" => "session=#{ID}", "REQUEST_METHOD" => "POST", :input => "name1=#{player_name_1}&name2=#{player_name_2}")
    req = Rack::Request.new(env)
    Service::State.initialize_game(req)
    state = Service::State.unmarshal(ID)

    assert_equal("Boule", state.players[0].name)
    assert_equal("Bill", state.players[1].name)
    File.delete("#{ID}.yml")
  end

  def test_players_number
    player_number = "2"
    env = Rack::MockRequest.env_for("", "HTTP_COOKIE" => "session=#{ID}", "REQUEST_METHOD" => "POST", :input => "number=#{player_number}")
    req = Rack::Request.new(env)
    Service::State.marshal_players_number(req)

    assert_equal(2, Service::State.players_number(req))
  end

  def test_marshal_unmarshal
    STATE.marshal
    state_test = Service::State.unmarshal(ID)

    assert_equal("id_test", state_test.id)
    assert_equal("player 1", state_test.players[0].name)
    assert_equal("player 2", state_test.players[1].name)
    assert_equal([], state_test.players[0].hand.cards)
    assert_equal("card: 1", state_test.players[1].hand.cards[0].name)
    assert_equal(2, state_test.players[1].hand.cards[1].id)
    assert_equal(3, state_test.players[1].hand.cards[2].cost)
    assert_equal(4, state_test.players[1].hand.cards[3].victory_points)
    assert_equal([], state_test.players[0].tableau.cards)
    assert_equal([], state_test.players[1].tableau.cards)
    assert_equal([], state_test.stack.cards)
    assert_equal([], state_test.graveyard.cards)
    File.delete("#{ID}.yml")
  end

  def test_detail_players
    players_test = Service::Detail.players(PLAYERS)

    assert_equal("player 1", players_test[0][Service::NAME])
    assert_equal([], players_test[0][Service::HAND])
    assert_equal([], players_test[1][Service::TABLEAU])
  end

  def test_detail_cards
    cards_test = Service::Detail.cards(CARDS)

    assert_equal("card: 1", cards_test[0][Service::NAME])
    assert_equal(2, cards_test[1][Service::ID])
    assert_equal(3, cards_test[2][Service::COST])
    assert_equal(4, cards_test[3][Service::VICTORY_POINTS])
  end

  def test_create_new_players
    STATE.marshal
    state_test = YAML.load(File.read("#{ID}.yml"))
    players_test = Service::Create.new_players(state_test[Service::PLAYERS])

    assert_equal("player 1", players_test[0].name)
    assert_equal([], players_test[1].tableau.cards)
    File.delete("#{ID}.yml")
  end

  def test_create_new_cards
    STATE.marshal
    state_test = YAML.load(File.read("#{ID}.yml"))
    cards_test = Service::Create.new_cards(state_test[Service::PLAYERS][1][Service::HAND])

    assert_equal("card: 1", cards_test[0].name)
    assert_equal(2, cards_test[1].id)
    assert_equal(3, cards_test[2].cost)
    assert_equal(4, cards_test[3].victory_points)
    File.delete("#{ID}.yml")
  end
end
