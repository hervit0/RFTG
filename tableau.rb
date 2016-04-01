require_relative 'card.rb'

class Tableau
  attr_reader:cards
  def initialize(cards)
    @cards = cards
  end
end
