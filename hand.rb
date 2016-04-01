require_relative 'card.rb'

class Hand
  attr_accessor :cards
  def initialize(cards)
    @cards = cards
  end
end
