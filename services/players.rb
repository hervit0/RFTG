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
    def self.number(request)
      request.POST.values.first.to_i
    end

    def self.introduce(request)
      id = Session.id(request)
      state = State.unmarshal(id)
      board = state.to_board
      player = board.next_player_to_discard
      IntroducePlayer.new(player)
    end

    def self.show_kept_cards(request)
      id = Session.id(request)
      state = State.unmarshal(id)
      board = state.to_board
      path = Session.next_action(board.count_players_havent_discard)

      first_card, second_card = request.POST.values.map{ |x| x.to_i }
      new_board, index_player  = board.make_player_discard(first_card, second_card)
      player = new_board.players[index_player]
      State.from_board(id, new_board).marshal

      [path, IntroducePlayer.new(player)]
    end
  end

  class IntroducePlayer
    attr_reader :name, :hand
    def initialize(player)
      @name = player.name
      @hand = Detail.cards(player.hand.cards)
    end
  end
end
