require_relative '../router.rb'

module Service
  class Session
    def self.next_action(number_players_havent_discard)
      number_players_havent_discard == 1 ? Router::Path::CHOOSE_PHASES : Router::Path::INTRODUCE_PLAYER
    end
  end
end
