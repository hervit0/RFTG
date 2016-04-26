require_relative 'card.rb'

module Model
  class Graveyard
    attr_reader :cards
    def initialize(cards)
      @cards = cards
    end

    def self.empty
      Graveyard.new([])
    end

    def add_cards(cards)
      Model::Graveyard.new(@cards + cards)
    end
  end
end
