require 'yaml'
require_relative 'session.rb'
require_relative '../models/player.rb'
require_relative '../models/stack.rb'
require_relative '../models/hand.rb'
require_relative '../models/card.rb'
require_relative '../models/graveyard.rb'
require_relative '../models/tableau.rb'

module Service
  ID = "id"
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

    def self.initialize_game(request)
      id = Session.id(request)
      names = request.POST.values
      board = Model::Board.initialize_game(names)
      State.from_board(id, board).marshal
    end

    def marshal
      state = {
        ID => @id,
        PLAYERS => Detail.players(@players),
        STACK => Detail.cards(@stack.cards),
        GRAVEYARD => Detail.cards(@graveyard.cards)
      }
      File.write("#{@id}.yml", state.to_yaml)
    end

    def self.unmarshal(id)
      state = YAML.load(File.read("#{id}.yml"))
      id = state[ID]
      players = Create.new_players(state[PLAYERS])
      stack = Model::Stack.new(Create.new_cards(state[STACK]))
      graveyard = Model::Graveyard.new(Create.new_cards(state[GRAVEYARD]))
      State.new(id, players, stack, graveyard)
    end

    def to_board
      Model::Board.new(@players, @stack, @graveyard)
    end

    def self.from_board(id, board)
      State.new(id, board.players, board.stack, board.graveyard)
    end
  end

  class Detail
    def self.players(players)
      players.map do |x|
        {NAME => x.name,
         HAND => Detail.cards(x.hand.cards),
         TABLEAU => Detail.cards(x.tableau.cards)}
      end
    end

    def self.cards(cards)
      cards.map do |x|
        {NAME => x.name,
         ID => x.id,
         COST => x.cost,
         VICTORY_POINTS => x.victory_points
        }
      end
    end
  end

  class Create
    def self.new_players(players)
      players.map do |x|
        Model::Player.new(
          x.fetch(NAME),
          Model::Hand.new(Create.new_cards(x.fetch(HAND))),
          Model::Tableau.new(Create.new_cards(x.fetch(TABLEAU)))
        )
      end
    end

    def self.new_cards(cards)
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
end
