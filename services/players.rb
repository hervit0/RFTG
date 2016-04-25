require 'yaml'
require_relative 'state.rb'
require_relative '../models/player.rb'
require_relative '../models/stack.rb'
require_relative '../models/hand.rb'
require_relative '../models/graveyard.rb'
require_relative '../models/tableau.rb'

CARDS = YAML.load(File.read("models/cards.yml"))

class Players
  def self.number(request)
    request.POST.values.first.to_i
  end

  def self.names(request)
    id = request.cookies["session"]
    stack = Stack.from_cards(CARDS)
    graveyard = Graveyard.new([])
    players = request.POST.to_a.map do |x|
      Player.new(x[1], Hand.new([]), Tableau.new([])).draw(6, stack).first
    end
    State.new(id, players, stack, graveyard).record
  end

  def self.present(request)
    id = request.cookies["session"]
    state = State.watch(id)
    player_index, player_name = next_player(state)
    player_name
  end

  def self.discard(request)
    id = request.cookies["session"]
    state = State.watch(id)
    player_index, player_name = next_player(state)
    player_name
  end

  def self.show_kept_cards(request)
    id = request.cookies["session"]
    state = State.watch(id)
    players_remaining = state.players.map{ |x| x.hand.cards.length }.count(6)
    action = players_remaining == 1 ? "choose_phases" : "present_player"
    binding.pry

    player_index, player_name = next_player(state)
    player = state.players[player_index]
    first, second = request.POST.values.map{ |x| x.to_i }
    graveyard = state.graveyard
    new_player, new_graveyard = player.choose_first_cards(graveyard, first, second)
    new_players = state.players.map.with_index{ |x,i| i == player_index ? new_player : x}
    new_state = State.new(state.id, new_players, state.stack, new_graveyard)
    player_index_new, player_name_new = next_player(new_state)

    [action, player_name_new]
  end
end

def next_player(state)
    hands_size = state.players.map{ |x| x.hand.cards.length }
    player_index = hands_size.index(6)
    player_name = state.players.map{ |x| x.name }[player_index]
    [player_index, player_name]
end
