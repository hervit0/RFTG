require 'yaml'
require_relative 'state.rb'
require_relative 'session.rb'
require_relative '../models/board.rb'
require_relative '../models/player.rb'
require_relative '../models/stack.rb'
require_relative '../models/hand.rb'
require_relative '../models/graveyard.rb'
require_relative '../models/tableau.rb'

module Service
  class Player
    Player = Struct.new(:name, :hand)

    def self.marshal_introduce(request)
      if request.POST != {}
        State.apply_discard(request)
      end
    end

    def self.introduce(request)
      id = Session.id(request)
      state = State.unmarshal(id)
      board = state.to_board
      path = Session.next_action(board.count_players_havent_discard)
      player = board.next_player_to_discard
      player_name = player.name
      player_hand = Cards.marshal_from(player.hand.cards)

      [path, Player.new(player_name, player_hand)]
    end
  end
end
