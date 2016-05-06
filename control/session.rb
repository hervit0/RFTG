require_relative '../router.rb'

module Control
  class Session
    def self.id(request)
      request.cookies[Router::SESSION]
    end
  end
end
