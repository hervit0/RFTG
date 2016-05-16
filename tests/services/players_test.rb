require 'minitest/autorun'
require 'rack'
require_relative '../../services/players.rb'
require_relative '../../services/state.rb'

class PlayersTest < Minitest::Unit::TestCase
  ID = 'id_test'
  CARDS = (1..6).to_a.map do |x|
    Model::Card.new(name: "card: #{x}", id: x, cost: x, victory_points: x)
  end
  PLAYERS = [
    Model::Player.new('player 1', Model::Hand.empty, Model::Tableau.empty),
    Model::Player.new('player 2', Model::Hand.new(CARDS), Model::Tableau.empty)]
  stack = Model::Stack.new([])
  graveyard = Model::Graveyard.empty
  STATE = Service::State.new(PLAYERS, stack, graveyard)
  ENVIRONMENT = Rack::MockRequest.env_for(
    '',
    'HTTP_COOKIE' => 'session=#{ID}',
    'REQUEST_METHOD' => 'POST',
    :input => 'first=1&second=6'
  )

  def test_introduce
    state = STATE.marshal
    path, player = Service::Player.introduce(state)
    id_cards = player.hand.map { |x| x[Service::ID] }

    assert_equal(Router::Path::CHOOSE_PHASES, path)
    assert_equal('player 2', player.name)
    assert_equal([1, 2, 3, 4, 5, 6], id_cards)
  end
end
