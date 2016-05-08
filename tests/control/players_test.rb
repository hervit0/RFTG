require 'rack'
require 'minitest/autorun'
require_relative '../../errors.rb'
require_relative '../../control/players.rb'

class PlayersControlTest < Minitest::Test
  def self.setup_request(input:)
    env = Rack::MockRequest.env_for("", "REQUEST_METHOD" => "POST", :input => input)
    req = Rack::Request.new(env)
  end

  def test_control_initial_cards
    errors = {
      Error::UnexpectedNumberOfCards => "first=1&second=2&third=3",
      Error::UnexpectedNumberOfCards => "first=1",
      Error::NotInteger => "first=one&second=2",
      Error::NotInteger => "first=1.2&second=2",
      Error::UnavailableIndexOfCard => "first=7&second=2",
      Error::UnavailableIndexOfCard => "first=2&second=-1"
    }
    errors.each do |key, value|
      request = PlayersControlTest.setup_request(input: value)
      assert_raises(key) do
        Control::Players.initial_cards(request)
      end
    end
  end
end
