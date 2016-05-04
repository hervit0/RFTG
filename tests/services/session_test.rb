require 'minitest/autorun'
require 'rack'
require_relative '../../services/session.rb'

class SessionTest < Minitest::Test
  ID = "id_test"
  ENVIRONMENT = Rack::MockRequest.env_for("", "HTTP_COOKIE" => "session=#{ID}", "REQUEST_METHOD" => "POST", :input => "first=1&second=6")

  def test_session_id
    request = Rack::Request.new(ENVIRONMENT)

    assert_equal("id_test", Service::Session.id(request))
  end

  def test_next_action
    {1 => Router::Path::CHOOSE_PHASES,
     2 => Router::Path::INTRODUCE_PLAYER,
     3 => Router::Path::INTRODUCE_PLAYER}.each do |key, value|
       assert_equal(value, Service::Session.next_action(key))
     end
  end
end
