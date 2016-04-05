require_relative 'tableau.rb'
require_relative 'hand.rb'
require_relative 'stack.rb'
require_relative 'graveyard.rb'

class Player
  attr_reader :hand, :tableau, :name
  def initialize(hand, tableau)
    @hand = hand
    @tableau = tableau
  end

  def give_name!
    puts "Give me your name:"
    @name = gets.chomp
  end

  def draw(number, stack)
    new_stack = stack.draw(number)
    new_cards = stack.cards - new_stack.cards
    new_hand = @hand.add_cards(new_cards)

    [Player.new(new_hand, @tableau), new_stack]
  end

  def choose_first_cards(graveyard)
    puts @hand.display
    puts "Choose first card to discard:"
    first = gets.chomp.to_i
    puts "Choose second card to discard:"
    second = gets.chomp.to_i

    new_hand = @hand.remove_cards(first, second)
    discarded_cards = @hand.cards - new_hand.cards
    new_graveyard = graveyard.add_cards(discarded_cards)

    [Player.new(new_hand, @tableau), new_graveyard]
  end

  def victory_points
    @tableau.cards.reduce(0){ |acc, ite| acc + ite.victory_points }
  end
end
