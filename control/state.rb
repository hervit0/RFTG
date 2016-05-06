require_relative '../errors.rb'

module Control
  EXPECTED_INPUT_FOR_PLAYERS_NUMBER = 1
  MAX_PLAYERS = 4
  MIN_PLAYERS = 0
  NUMBER_OF_DISCARDED_CARDS = 2
  AVAILABLE_INDEXES = (1..6).to_a

  class State
    def self.players_number(request)
      raise Error::EmptyPost if request.POST == {}
      result = request.POST.values
      raise Error::UnexpectedNumberOfInputs if result.size != EXPECTED_INPUT_FOR_PLAYERS_NUMBER
      raise Error::NotInteger if result.first.to_i.to_s != result.first
      players_number = result.first.to_i
      raise Error::TooManyPlayers if players_number > MAX_PLAYERS
      raise Error::NotEnoughPlayers if players_number <= MIN_PLAYERS
      players_number
    end

    def self.players_names(request)
      raise Error::EmptyPost if request.POST == {}
      request.POST.values
    end

    def self.discarded_cards(request)
      raise Error::EmptyPost if request.POST == {}
      result = request.POST.values
      raise Error::UnexpectedNumberOfInputs if result.size != NUMBER_OF_DISCARDED_CARDS
      result.each do |x|
        raise Error::NotInteger if x.to_i.to_s != x
      end
      result.each do |x|
        raise Error::UnavailableIndexOfCard unless AVAILABLE_INDEXES.include?(x.to_i)
      end
      request.POST.values.map{ |x| x.to_i }
    end
  end
end
