require_relative '../router.rb'

module Service
  class Session
    def self.next_action(number_players_havent_discard)
      if number_players_havent_discard == 1
        Router::Path::CHOOSE_PHASES
      else
        Router::Path::INTRODUCE_PLAYER
      end
    end
  end
end
