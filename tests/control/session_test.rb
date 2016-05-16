require 'rack'
require 'minitest/autorun'
require_relative '../../errors.rb'
require_relative '../../control/session.rb'

class SessionControlTest < Minitest::Unit::TestCase
  def self.setup_request(input:)
    env = Rack::MockRequest.env_for(
      '',
      'REQUEST_METHOD' => 'POST',
      'HTTP_COOKIE' => input
    )
    Rack::Request.new(env)
  end

  def test_control_id
    errors = {
      Error::NoCookieInRequest => '',
      Error::NoSessionID => 'other_thing=other'
    }
    errors.each do |key, value|
      request = SessionControlTest.setup_request(input: value)
      assert_raises(key) do
        Control::Session.id(request)
      end
    end
  end
end
