require_relative '../router.rb'
require_relative '../errors.rb'

module Control
  class Session
    def self.id(request)
      raise Error::NoCookieInRequest if request.cookies == {}
      raise Error::NoSessionID unless request.cookies.key?(Router::SESSION)
      request.cookies[Router::SESSION]
    end
  end
end
