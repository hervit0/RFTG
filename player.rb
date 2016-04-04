require_relative 'tableau.rb'
require_relative 'hand.rb'
require_relative 'stack.rb'

class Player
  attr_reader :hand, :tableau, :stack
  def initialize(hand, tableau, stack)
    @hand = hand
    @tableau = tableau
    @stack = stack
  end

  def give_name!
    puts "Give me your name:"
    @name = gets.chomp
  end

  def name
    @name
  end

  def draw(number)
    new_stack = @stack.draw_cards(number)
    new_cards = @stack.cards - new_stack.cards
    new_hand = @hand.add_cards(new_cards)

    Player.new(new_hand, @tableau, new_stack)
  end

  def choose_first_cards
    puts @hand.display
    puts "Choose first card to discard:"
    first = gets.chomp.to_i
    puts "Choose second card to discard:"
    second = gets.chomp.to_i
    @hand.remove_card(first, second)
  end

  def victory_points
    @tableau.cards.reduce(0){ |acc, ite| acc + ite.victory_points }
  end
end
