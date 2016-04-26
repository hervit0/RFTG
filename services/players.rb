require 'yaml'
require_relative 'state.rb'
require_relative '../router.rb'
require_relative '../models/player.rb'
require_relative '../models/stack.rb'
require_relative '../models/hand.rb'
require_relative '../models/graveyard.rb'
require_relative '../models/tableau.rb'

module Service
  CARDS = YAML.load(File.read("models/cards.yml"))

  class Player
    def self.number(request)
      request.POST.values.first.to_i
    end

    def self.present(request)
      id = request.cookies[Router::SESSION]
      state = Service::State.watch(id)
      player_index, player_name = next_player(state)
      player_hand = Service::Detail.cards(state.players[player_index].hand.cards)
      [player_name, player_hand]
    end

    def self.show_kept_cards(request)
      id = request.cookies[Router::SESSION]
      state = Service::State.watch(id)
      players_remaining = state.players.map{ |x| x.hand.cards.length }.count(6)
      action = players_remaining == 1 ? Router::PATH_CHOOSE_PHASES : Router::PATH_PRESENT_PLAYER

      player_index, player_name = next_player(state)
      player = state.players[player_index]
      first, second = request.POST.values.map{ |x| x.to_i }
      graveyard = state.graveyard
      new_player, new_graveyard = player.choose_first_cards(graveyard, first, second)
      new_players = state.players.map.with_index{ |x,i| i == player_index ? new_player : x}
      new_state = Service::State.new(state.id, new_players, state.stack, new_graveyard).record
      player_hand = Service::Detail.cards(Service::State.watch(id).players[player_index].hand.cards)

      [action, player_name, player_hand]
    end

    def self.next_player(state)
      hands_size = state.players.map{ |x| x.hand.cards.length }
      player_index = hands_size.index(6)
      player_name = state.players.map{ |x| x.name }[player_index]
      [player_index, player_name]
    end
    private_class_method :next_player
  end
end
