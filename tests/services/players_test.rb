require 'minitest/autorun'
require 'rack'
require_relative '../../services/players.rb'
require_relative '../../services/state.rb'

class PlayersTest < Minitest::Test
  @@id = "id_test"
  cards = (1..6).to_a.map do |x|
    Model::Card.new(name: "card: #{x}", id: x,  cost: x, victory_points: x)
  end
  players = [
    Model::Player.new("player 1", Model::Hand.empty, Model::Tableau.empty),
    Model::Player.new("player 2", Model::Hand.new(cards), Model::Tableau.empty)]
  stack = Model::Stack.new([])
  graveyard = Model::Graveyard.empty
  @@state = Service::State.new(@@id, players, stack, graveyard)


  def test_present
    @@state.record
    env = Rack::MockRequest.env_for("", "HTTP_COOKIE" => "session=#{@@id}", "REQUEST_METHOD" => "POST")
    req = Rack::Request.new(env)
    player_name, player_hand = Service::Player.present(req)
    id_cards = player_hand.map{ |x| x["id"] }

    assert_equal("player 2", player_name)
    assert_equal([1, 2, 3, 4, 5, 6], id_cards)
    File.delete("#{@@id}.yml")
  end

  def test_show_kept_cards
    @@state.record
    env = Rack::MockRequest.env_for("", "HTTP_COOKIE" => "session=#{@@id}", "REQUEST_METHOD" => "POST", :input => "first=1&second=6")
    req = Rack::Request.new(env)
    action, player_name, player_hand = Service::Player.show_kept_cards(req)
    id_cards = player_hand.map{ |x| x["id"] }

    assert_equal(Router::PATH_CHOOSE_PHASES, action)
    assert_equal("player 2", player_name)
    assert_equal([2, 3, 4, 5], id_cards)
    File.delete("#{@@id}.yml")
  end

  def test_next_players
    player_index, player_name = Service::Player.send(:next_player, @@state)

    assert_equal(1, player_index)
    assert_equal("player 2", player_name)
  end
end
