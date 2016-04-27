require 'yaml'
require_relative '../router.rb'
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
  CARDS = YAML.load(File.read(File.join(File.expand_path(File.dirname(__FILE__)),"../models/cards.yml")))

  class State
    attr_reader :id, :players, :stack, :graveyard
    def initialize(id, players, stack, graveyard)
      @id = id
      @players = players
      @stack = stack
      @graveyard = graveyard
    end

    def self.initialize_game(request)
      id = request.cookies[Router::SESSION]
      graveyard = Model::Graveyard.empty
      hand = Model::Hand.empty
      tableau = Model::Hand.empty
      names = request.POST.to_a.map{ |x| x.last.capitalize }
      players, stack = names.reduce([[], Model::Stack.from_cards(Service::CARDS)]) do |ac, it|
        new_player, new_stack = Model::Player.new(it, hand, tableau).draw(6, ac.last)
        [ac.first + [new_player], new_stack]
      end

      Service::State.new(id, players, stack, graveyard).record
    end

    def record
      state = {
        Service::ID => @id,
        Service::PLAYERS => Service::Detail.players(@players),
        Service::STACK => Service::Detail.cards(@stack.cards),
        Service::GRAVEYARD => Service::Detail.cards(@graveyard.cards)
      }
      File.write("#{@id}.yml", state.to_yaml)
    end

    def self.watch(id)
      state = YAML.load(File.read("#{id}.yml"))
      id = state[Service::ID]
      players = Service::Create.new_players(state[Service::PLAYERS])
      stack = Model::Stack.new(Service::Create.new_cards(state[Service::STACK]))
      graveyard = Model::Graveyard.new(Service::Create.new_cards(state[Service::GRAVEYARD]))
      Service::State.new(id, players, stack, graveyard)
    end
  end

  class Detail
    def self.players(players)
      players.map do |x|
        {Service::NAME => x.name,
         Service::HAND => Service::Detail.cards(x.hand.cards),
         Service::TABLEAU => Service::Detail.cards(x.tableau.cards)}
      end
    end

    def self.cards(cards)
      cards.map do |x|
        {Service::NAME => x.name,
         Service::ID => x.id,
         Service::COST => x.cost,
         Service::VICTORY_POINTS => x.victory_points
        }
      end
    end
  end

  class Create
    def self.new_players(players)
      players.map do |x|
        Model::Player.new(
          x[Service::NAME],
          Model::Hand.new(Service::Create.new_cards(x[Service::HAND])),
          Model::Tableau.new(Service::Create.new_cards(x[Service::TABLEAU]))
        )
      end
    end

    def self.new_cards(cards)
      cards == [] ? [] :
        cards.map do |x|
        Model::Card.new(
          name: x[Service::NAME],
          id: x[Service::ID],
          cost: x[Service::COST],
          victory_points: x[Service::VICTORY_POINTS]
        )
      end
    end
  end
end
