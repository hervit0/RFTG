require_relative 'tableau.rb'
require_relative 'hand.rb'

class Player
  attr_accessor :name, :hand, :tableau
  def initialize(name, hand, tableau)
    @name = name
    @hand = hand
    @tableau = tableau 
  end

  def victory_points 
    @tableau.cards.reduce(0){ |acc, ite| acc + ite.victory_points }
  end
end
