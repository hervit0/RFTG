require 'yaml'
require_relative '../models/player.rb'
require_relative '../models/stack.rb'
require_relative '../models/hand.rb'
require_relative '../models/card.rb'
require_relative '../models/graveyard.rb'
require_relative '../models/tableau.rb'

module Service
  class State
    attr_reader :id, :players, :stack, :graveyard
    def initialize(id, players, stack, graveyard)
      @id = id
      @players = players
      @stack = stack
      @graveyard = graveyard
    end

    def self.initialize_game(request)
      id = request.cookies["session"]
      graveyard = Graveyard.new([])

      names = request.POST.to_a.map{ |x| x.last.capitalize }
      players, stack = names.reduce([[], Stack.from_cards(CARDS)]) do |ac, it|
        new_player, new_stack = Model::Player.new(it, Hand.new([]), Tableau.new([])).draw(6, ac.last)
        [ac.first + [new_player], new_stack]
      end

      Service::State.new(id, players, stack, graveyard).record
    end

    def record
      state = {
        "id" => @id,
        "players" => Service::Detail.players(@players),
        "stack" => Service::Detail.cards(@stack.cards),
        "graveyard" => Service::Detail.cards(@graveyard.cards)
      }
      File.write("#{@id}.yml", state.to_yaml)
    end

    def self.watch(id)
      state = YAML.load(File.read("#{id}.yml"))
      id = state["id"]
      players = Service::Create.new_players(state["players"])
      stack = Stack.new(Service::Create.new_cards(state["stack"]))
      graveyard = Graveyard.new(Service::Create.new_cards(state["graveyard"]))
      Service::State.new(id, players, stack, graveyard)
    end
  end

  class Detail
    def self.players(players)
        players.map do |x|
          {"name" => x.name,
           "hand" => Service::Detail.cards(x.hand.cards),
           "tableau" => Service::Detail.cards(x.tableau.cards)}
        end
      end

    def self.cards(cards)
        cards.map do |x|
          {"name" => x.name,
           "id" => x.id,
           "cost" => x.cost,
           "victory_points" => x.victory_points
          }
        end
      end
  end

  class Create
    def self.new_players(players)
        players.map do |x|
          Model::Player.new(
            x["name"],
            Hand.new(Service::Create.new_cards(x["hand"])),
            Tableau.new(Service::Create.new_cards(x["tableau"]))
          )
        end
      end

    def self.new_cards(cards)
        cards == [] ? [] :
          cards.map do |x|
          Card.new(
            name: x["name"],
            id: x["id"],
            cost: x["cost"],
            victory_points: x["victory_points"]
          )
        end
      end
  end
end
