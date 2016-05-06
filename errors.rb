module Error
  class EmptyPost < ArgumentError; end
  class NoPlayersNames < ArgumentError; end
  class NoCookieInRequest < ArgumentError; end
  class NoSessionID < ArgumentError; end

  class NotInteger < TypeError; end

  class UnexpectedNumberOfInputs < RangeError; end
  class UnexpectedNumberOfCards < RangeError; end
  class TooManyPlayers < RangeError; end
  class NotEnoughPlayers < RangeError; end

  class UnavailableIndexOfCard < IndexError; end
end
