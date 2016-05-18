require_relative '../errors.rb'

module Control
  INPUT_PLAYERS_NUMBER = 1
  MAX_PLAYERS = 4
  MIN_PLAYERS = 0
  NUMBER_DISCARDED_CARDS = 2
  AVAILABLE_INDEXES = (1..6).to_a

  class State
    def self.players_number(request)
      raise Error::EmptyPost if request.POST == {}
      result = request.POST.values
      check_input = result.size != INPUT_PLAYERS_NUMBER
      raise Error::UnexpectedNumberOfInputs if check_input
      raise Error::NotInteger if result.first.to_i.to_s != result.first
      players_number = result.first.to_i
      raise Error::TooManyPlayers if players_number > MAX_PLAYERS
      raise Error::NotEnoughPlayers if players_number <= MIN_PLAYERS
      players_number
    end

    def self.players_names(request)
      raise Error::EmptyPost if request.POST == {}
      names = request.POST.values
      names.each do |name|
        raise Error::NoPlayersNames if name.delete(' ').empty?
      end
      names
    end

    def self.discarded_cards(request)
      raise Error::EmptyPost if request.POST == {}
      result = request.POST.values
      check_input = result.size != NUMBER_DISCARDED_CARDS
      raise Error::UnexpectedNumberOfCards if check_input
      result.each do |x|
        raise Error::NotInteger if x.to_i.to_s != x
      end
      result.each do |x|
        check_indexes = AVAILABLE_INDEXES.include?(x.to_i)
        raise Error::UnavailableIndexOfCard unless check_indexes
      end
      request.POST.values.map(&:to_i)
    end
  end
end
