require 'yaml'
require_relative 'card.rb'
require_relative 'stack.rb'
require_relative 'graveyard.rb'
require_relative 'hand.rb'
require_relative 'player.rb'
require_relative 'tableau.rb'

PLAYERS_NUMBER = 2
PLAYERS_NUMBER_MAX = 4
CARDS = YAML.load(File.read("cards.yml"))

def set_players_names
  (1..PLAYERS_NUMBER).to_a.map{ |x| p "Write player#{x}'s name:"; gets.chomp}
end

PLAYERS_NAMES = set_players_names

library = Stack.new(
  CARDS.map do |item|
    Card.new(item["name"], item["cost"], item["victory_points"])
  end
)

def distribute_cards(cards, number_players)
  beginning_hands = cards.sample(number_players * 6).each_slice(6).to_a
  stack_after_distribution = cards - beginning_hands.flatten
  [beginning_hands, stack_after_distribution]
end

def discard(distributions)
  hands = distributions[0].map.with_index do |hand, i|
    p "Player#{i+1}'s cards are the following:"
    puts "\n"
    hand.map.with_index{ |n,i| p "card #{i+1}:"; p n; puts "\n" }
    
    p "Please discard 2 cards"
    p "Press number of the first card to discard"
    number_first_card_discarded = gets.chomp.to_i - 1
    p "Press number of the second card to discard"
    number_second_card_discarded = gets.chomp.to_i - 1
		
    hand - [hand[number_first_card_discarded]] - [hand[number_second_card_discarded]]
  end

  discarded_cards = distributions[0].flatten - hands.flatten

  stack_after_distribution = distributions.last

  [hands, stack_after_distribution, discarded_cards]
end

def specify_player(hands, tableaux)
  (0..PLAYERS_NUMBER-1).map do |i|
    Player.new(PLAYERS_NAMES[i], hands[i], tableaux[i])
  end
end

first_distribution = discard(distribute_cards(library.cards, PLAYERS_NUMBER))

first_hands = (0..PLAYERS_NUMBER-1).map{ |i| Hand.new(first_distribution[0][i]) }
first_stack = Stack.new(first_distribution[1])
first_graveyard = Graveyard.new(first_distribution[2])	
first_tableaux = (0..PLAYERS_NUMBER-1).map{ |i| Tableau.new([]) }

players = specify_player(first_hands, first_tableaux)
