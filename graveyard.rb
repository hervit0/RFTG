require_relative 'card.rb'

class Graveyard
  attr_accessor :cards
  def initialize(cards)
    @cards = cards
  end
end
