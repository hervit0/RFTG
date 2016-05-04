module Error
  EXPECTED_INPUT_FOR_PLAYERS_NUMBER = 1
  MAX_PLAYERS = 4
  MIN_PLAYERS = 0
  NUMBER_OF_DISCARDED_CARDS = 2
  AVAILABLE_INDEXES = (1..6).to_a

  class Control
    def self.number_of_players(request)
      raise EmptyPost if request.POST == {}
      result = request.POST.values
      raise UnexpectedNumberOfInputs if result.size != EXPECTED_INPUT_FOR_PLAYERS_NUMBER
      raise NotInteger if result.first.to_i.to_s != result.first
      number = result.first.to_i
      raise TooManyPlayers if number > MAX_PLAYERS
      raise NotEnoughPlayers if number <= MIN_PLAYERS
    end

    def self.discarded_cards(request)
      raise EmptyPost if request.POST == {}
      result = request.POST.values
      raise UnexpectedNumberOfInputs if result.size != NUMBER_OF_DISCARDED_CARDS
      result.each do |x|
        raise NotInteger if x.to_i.to_s != x
      end
      result.each do |x|
        raise UnavailableIndexOfCard unless AVAILABLE_INDEXES.include?(x.to_i)
      end
    end
  end

  class EmptyPost < RuntimeError; end
  class UnexpectedNumberOfInputs < RuntimeError; end
  class NotInteger < RuntimeError; end
  class TooManyPlayers < RuntimeError; end
  class NotEnoughPlayers < RuntimeError; end
  class UnavailableIndexOfCard < RuntimeError; end
end
