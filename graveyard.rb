require_relative 'card.rb'

class Graveyard
  def initialize(cards_graveyard)
    @cards_graveyard = cards_graveyard
  end

  def show_cards_graveyard
    p @cards_graveyard
  end
end
