require_relative 'tableau.rb'
require_relative 'hand.rb'

class Player
  attr_accessor :name, :hand, :tableau
  def initialize(name, hand, tableau)
    @name = name
    @hand = hand
    @tableau = board
  end

  def victory_points 
    if @tableau.cards.length == 0
      0
    else
      @tableau.cards.reduce(0){ |acc, ite| acc + ite.values_at["victory_points"]}
    end
  end
end
