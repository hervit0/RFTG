require 'minitest/autorun'
require 'rack'
require_relative '../../services/state.rb'

class StateTest < Minitest::Test
  @@id = "id_test"
  @@cards = (1..6).to_a.map do |x|
    Model::Card.new(name: "card: #{x}", id: x,  cost: x, victory_points: x)
  end
  @@players = [
    Model::Player.new("player 1", Model::Hand.empty, Model::Tableau.empty),
    Model::Player.new("player 2", Model::Hand.new(@@cards), Model::Tableau.empty)]
  stack = Model::Stack.new([])
  graveyard = Model::Graveyard.empty
  @@state = Service::State.new(@@id, @@players, stack, graveyard)

  def test_initialize_game
    player_name_1 = "boule"
    player_name_2 = "bill"
    env = Rack::MockRequest.env_for("", "HTTP_COOKIE" => "session=#{@@id}", "REQUEST_METHOD" => "POST", :input => "name1=#{player_name_1}&name2=#{player_name_2}")
    req = Rack::Request.new(env)
    Service::State.initialize_game(req)
    state = Service::State.watch(@@id)

    assert_equal("Boule", state.players[0].name)
    assert_equal("Bill", state.players[1].name)
    File.delete("#{@@id}.yml")
  end

  def test_record_watch
    @@state.record
    state_test = Service::State.watch(@@id)

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
    File.delete("#{@@id}.yml")
  end

  def test_detail_players
    players_test = Service::Detail.players(@@players)

    assert_equal("player 1", players_test[0][Service::NAME])
    assert_equal([], players_test[0][Service::HAND])
    assert_equal([], players_test[1][Service::TABLEAU])
  end

  def test_detail_cards
    cards_test = Service::Detail.cards(@@cards)

    assert_equal("card: 1", cards_test[0][Service::NAME])
    assert_equal(2, cards_test[1][Service::ID])
    assert_equal(3, cards_test[2][Service::COST])
    assert_equal(4, cards_test[3][Service::VICTORY_POINTS])
  end

  def test_create_new_players
    @@state.record
    state_test = YAML.load(File.read("#{@@id}.yml"))
    players_test = Service::Create.new_players(state_test[Service::PLAYERS])

    assert_equal("player 1", players_test[0].name)
    assert_equal([], players_test[1].tableau.cards)
    File.delete("#{@@id}.yml")
  end

  def test_create_new_cards
    @@state.record
    state_test = YAML.load(File.read("#{@@id}.yml"))
    cards_test = Service::Create.new_cards(state_test[Service::PLAYERS][1][Service::HAND])

    assert_equal("card: 1", cards_test[0].name)
    assert_equal(2, cards_test[1].id)
    assert_equal(3, cards_test[2].cost)
    assert_equal(4, cards_test[3].victory_points)
    File.delete("#{@@id}.yml")
  end
end
