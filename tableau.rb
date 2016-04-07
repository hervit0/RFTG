require_relative 'card.rb'

class Tableau
  attr_reader:cards
  def initialize(cards)
    @cards = cards
  end

  def victory_points
    @cards.reduce(0){ |acc, ite| acc + ite.victory_points }
  end
end
