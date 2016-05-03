require 'minitest/autorun'
require 'rack'
require_relative '../../services/players.rb'
require_relative '../../services/state.rb'

class PlayersTest < Minitest::Test
  ID = "id_test"
  CARDS = (1..6).to_a.map do |x|
    Model::Card.new(name: "card: #{x}", id: x,  cost: x, victory_points: x)
  end
  PLAYERS = [
    Model::Player.new("player 1", Model::Hand.empty, Model::Tableau.empty),
    Model::Player.new("player 2", Model::Hand.new(CARDS), Model::Tableau.empty)]
  stack = Model::Stack.new([])
  graveyard = Model::Graveyard.empty
  STATE = Service::State.new(ID, PLAYERS, stack, graveyard)
  ENVIRONMENT = Rack::MockRequest.env_for("", "HTTP_COOKIE" => "session=#{ID}", "REQUEST_METHOD" => "POST", :input => "first=1&second=6")

  def test_introduce
    STATE.marshal
    request = Rack::Request.new(ENVIRONMENT)
    next_player = Service::Player.introduce(request)
    id_cards = next_player.hand.map{ |x| x[Service::ID] }

    assert_equal("player 2", next_player.name)
    assert_equal([1, 2, 3, 4, 5, 6], id_cards)
    File.delete("#{ID}.yml")
  end

  def test_discard
    STATE.marshal
    request = Rack::Request.new(ENVIRONMENT)
    path, player = Service::Player.discard(request)
    id_cards = player.hand.map{ |x| x[Service::ID] }

    assert_equal(Router::Path::CHOOSE_PHASES, path)
    assert_equal("player 2", player.name)
    assert_equal([1, 2, 3, 4, 5, 6], id_cards)
    File.delete("#{ID}.yml")
  end

  def test_introduce_player
    player = Service::IntroducePlayer.new(PLAYERS[0])

    assert_equal("player 1", player.name)
    assert_equal([], player.hand)
  end
end
