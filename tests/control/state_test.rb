require 'rack'
require 'minitest/autorun'
require_relative '../../errors.rb'
require_relative '../../control/state.rb'

class StateControlTest < Minitest::Unit::TestCase
  def self.setup_request(input:)
    env = Rack::MockRequest.env_for(
      '',
      'REQUEST_METHOD' => 'POST',
      :input => input
    )
    Rack::Request.new(env)
  end

  def test_control_players_number
    errors = {
      Error::EmptyPost => '',
      Error::UnexpectedNumberOfInputs => 'number=2&something_else=anormal',
      Error::NotInteger => 'number=eleven',
      Error::TooManyPlayers => 'number=5',
      Error::NotEnoughPlayers => 'number=0'
    }
    errors.each do |key, value|
      request = StateControlTest.setup_request(input: value)
      assert_raises(key) do
        Control::State.players_number(request)
      end
    end
  end

  def test_control_players_names
    errors = {
      Error::EmptyPost => '',
      Error::NoPlayersNames => 'name1=&name2=',
      Error::NoPlayersNames => 'name1=john&name2=',
      Error::NoPlayersNames => 'name1=&name2=doe'
    }
    errors.each do |key, value|
      request = StateControlTest.setup_request(input: value)
      assert_raises(key) do
        Control::State.players_names(request)
      end
    end
  end

  def test_discarded_cards
    errors = {
      Error::EmptyPost => '',
      Error::UnexpectedNumberOfCards => 'first=1&second=2&third=3',
      Error::UnexpectedNumberOfCards => 'first=1',
      Error::NotInteger => 'first=one&second=2',
      Error::NotInteger => 'first=1.2&second=2',
      Error::UnavailableIndexOfCard => 'first=7&second=2',
      Error::UnavailableIndexOfCard => 'first=2&second=-1'
    }
    errors.each do |key, value|
      request = StateControlTest.setup_request(input: value)
      assert_raises(key) do
        Control::State.discarded_cards(request)
      end
    end
  end
end
