require_relative 'card.rb'

class Tableau
  attr_accessor :cards
  def initialize(cards)
    @cards = cards
  end
end
