require 'yaml'
require_relative '../models/player.rb'
require_relative '../models/stack.rb'
require_relative '../models/hand.rb'
require_relative '../models/card.rb'
require_relative '../models/graveyard.rb'
require_relative '../models/tableau.rb'

module Service
  ID = "id"
  PLAYERS_NUMBER = "players_number"
  PLAYERS = "players"
  STACK = "stack"
  GRAVEYARD = "graveyard"
  NAME = "name"
  HAND = "hand"
  TABLEAU = "tableau"
  COST = "cost"
  VICTORY_POINTS = "victory_points"

  class State
    attr_reader :id, :players, :stack, :graveyard
    def initialize(id, players, stack, graveyard)
      @id = id
      @players = players
      @stack = stack
      @graveyard = graveyard
    end

    def self.marshal_players_number(id, players_number)
      File.write("#{id}.yml", {PLAYERS_NUMBER => players_number}.to_yaml)
    end

    def self.players_number(id)
      data = YAML.load(File.read("#{id}.yml"))
      File.delete("#{id}.yml")
      data[PLAYERS_NUMBER].to_i
    end

    def self.initialize_game(id, names)
      board = Model::Board.initialize_game(names)
      State.from_board(id, board).marshal
    end

    def marshal
      state = {
        ID => @id,
        PLAYERS => Players.marshal_from(@players),
        STACK => Cards.marshal_from(@stack.cards),
        GRAVEYARD => Cards.marshal_from(@graveyard.cards)
      }
      File.write("#{@id}.yml", state.to_yaml)
    end

    def self.unmarshal(id)
      state = YAML.load(File.read("#{id}.yml"))
      id_session = state[ID]
      players = Players.unmarshal_from(state[PLAYERS])
      stack = Model::Stack.new(Cards.unmarshal_from(state[STACK]))
      graveyard = Model::Graveyard.new(Cards.unmarshal_from(state[GRAVEYARD]))
      State.new(id_session, players, stack, graveyard)
    end

    def to_board
      Model::Board.new(@players, @stack, @graveyard)
    end

    def self.from_board(id, board)
      State.new(id, board.players, board.stack, board.graveyard)
    end

    def self.make_player_discard(id, first_card, second_card)
      state = State.unmarshal(id)
      board = state.to_board
      new_board = board.make_player_discard(first_card, second_card)
      State.from_board(id, new_board).marshal
    end
  end

  class Cards
    def self.marshal_from(cards)
      cards.map do |x|
        {NAME => x.name,
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
        {NAME => x.name,
         HAND => Cards.marshal_from(x.hand.cards),
         TABLEAU => Cards.marshal_from(x.tableau.cards)}
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
