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
      if request.POST != {}
        State.apply_discard(request)
      end

      id = Session.id(request)
      state = State.unmarshal(id)
      board = state.to_board
      player = board.next_player_to_discard

      IntroducePlayer.new(player)
    end

    def self.discard(request)
      id = Session.id(request)
      state = State.unmarshal(id)
      board = state.to_board
      path = Session.next_action(board.count_players_havent_discard)
      #actualise board ?
      player = board.next_player_to_discard

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
