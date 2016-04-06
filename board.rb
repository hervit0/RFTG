require 'yaml'

STACK = YAML.load(File.read("cards.yml"))
PLAYERS_NUMBER = 2
PLAYERS_NUMBER_MAX = 4

def distribute_cards(cards, number_players)
  beginning_hands = cards.sample(number_players * 6).each_slice(6).to_a
  stack_after_distribution = cards - beginning_hands.flatten
	[beginning_hands, stack_after_distribution]
end

def discard
  distributions = distribute_cards(STACK, PLAYERS_NUMBER)

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

  [distributions.last, hands, discarded_cards]
end

class Board
  def initialize(stack, hands, boards, graveyard)
    @stack = stack
    @hands = hands
    @boards = boards
    @graveyard = graveyard
  end

  def state
    p "Number of cards in the stack:"
    p @stack.length
    p "Number of cards in the graveyard:"
    p @graveyard.length
  end
end

first_distribution = discard
first_board = Board.new(first_distribution[0], first_distribution[1], [], first_distribution[2])

first_board.state
