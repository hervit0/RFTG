require_relative '../router.rb'

module Service
  class Session
    def self.id(request)
      request.cookies[Router::SESSION]
    end

    def self.next_action(number_players_havent_discard)
      number_players_havent_discard == 1 ? Router::Path::CHOOSE_PHASES : Router::Path::PRESENT_PLAYER
    end
  end
end
