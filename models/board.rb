require_relative 'stack.rb'

PLAYERS_NUMBER = 2
PLAYERS_NUMBER_MAX = 4

module Model
  class Board
    attr_reader :stack
    def initialize(stack)
      @stack = stack
    end
  end
end
