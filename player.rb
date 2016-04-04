require_relative 'tableau.rb'
require_relative 'hand.rb'

class Player
  attr_reader :hand, :tableau
  def initialize(hand, tableau)
    @hand = hand
    @tableau = tableau
  end

  def give_name!
    puts "Give me your name:"
    @name = gets.chomp
  end

  def draw(number)
    @hand.draw_cards(number)
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
