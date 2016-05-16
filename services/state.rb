require_relative '../models/player.rb'
require_relative '../models/stack.rb'
require_relative '../models/hand.rb'
require_relative '../models/card.rb'
require_relative '../models/graveyard.rb'
require_relative '../models/tableau.rb'
require_relative '../persistence/persistence.rb'

module Service
  ID = :id
  PLAYERS_NUMBER = :players_number
  PLAYERS = :players
  STACK = :stack
  GRAVEYARD = :graveyard
  NAME = :name
  HAND = :hand
  TABLEAU = :tableau
  COST = :cost
  VICTORY_POINTS = :victory_points

  class State
    attr_reader :players, :stack, :graveyard
    def initialize(players, stack, graveyard)
      @players = players
      @stack = stack
      @graveyard = graveyard
    end

    def self.marshal_players_number(players_number)
      { PLAYERS_NUMBER => players_number }
    end

    def self.players_number(state)
      state[PLAYERS_NUMBER].to_i
    end

    def self.initialize_game(names)
      board = Model::Board.initialize_game(names)
      State.from_board(board).marshal
    end

    def marshal
      {
        PLAYERS => Players.marshal_from(@players),
        STACK => Cards.marshal_from(@stack.cards),
        GRAVEYARD => Cards.marshal_from(@graveyard.cards)
      }
    end

    def self.unmarshal(state)
      players = Players.unmarshal_from(state[PLAYERS])
      stack = Model::Stack.new(Cards.unmarshal_from(state[STACK]))
      graveyard = Model::Graveyard.new(Cards.unmarshal_from(state[GRAVEYARD]))
      State.new(players, stack, graveyard)
    end

    def to_board
      Model::Board.new(@players, @stack, @graveyard)
    end

    def self.from_board(board)
      State.new(board.players, board.stack, board.graveyard)
    end

    def self.make_player_discard(state, first_card, second_card)
      board = State.unmarshal(state).to_board
      new_board = board.make_player_discard(first_card, second_card)
      State.from_board(new_board).marshal
    end
  end

  class Cards
    def self.marshal_from(cards)
      cards.map do |x|
        {
          NAME => x.name,
          ID => x.id,
          COST => x.cost,
          VICTORY_POINTS => x.victory_points
        }
      end
    end

    def self.unmarshal_from(cards)
      cards.map do |x|
        Model::Card.new(
          name: x.fetch(NAME),
          id: x.fetch(ID),
          cost: x.fetch(COST),
          victory_points: x.fetch(VICTORY_POINTS)
        )
      end
    end
  end

  class Players
    def self.marshal_from(players)
      players.map do |x|
        {
          NAME => x.name,
          HAND => Cards.marshal_from(x.hand.cards),
          TABLEAU => Cards.marshal_from(x.tableau.cards)
        }
      end
    end

    def self.unmarshal_from(players)
      players.map do |x|
        Model::Player.new(
          x.fetch(NAME),
          Model::Hand.new(Cards.unmarshal_from(x.fetch(HAND))),
          Model::Tableau.new(Cards.unmarshal_from(x.fetch(TABLEAU)))
        )
      end
    end
  end
end
