require 'minitest/autorun'
require 'rack'
require_relative '../../services/session.rb'

class SessionTest < Minitest::Test
  def test_next_action
    {1 => Router::Path::CHOOSE_PHASES,
     2 => Router::Path::INTRODUCE_PLAYER,
     3 => Router::Path::INTRODUCE_PLAYER}.each do |key, value|
       assert_equal(value, Service::Session.next_action(key))
     end
  end
end
