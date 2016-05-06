require_relative 'state.rb'
require_relative '../errors.rb'

module Control
  class Players
    def self.initial_cards(request)
      if request.POST != {}
        first_card, second_card = State.discarded_cards(request)
      else
       :empty
      end
    end
  end
end
