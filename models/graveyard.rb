require_relative 'card.rb'

class Graveyard
  attr_reader :cards
  def initialize(cards)
    @cards = cards
  end

  def add_cards(cards)
    Graveyard.new(@cards + cards)
  end
end
