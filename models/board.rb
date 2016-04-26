require 'yaml'
require_relative 'stack.rb'

PLAYERS_NUMBER = 2
PLAYERS_NUMBER_MAX = 4
CARDS = YAML.load(File.read("cards.yml"))

module Model
  class Board
    attr_reader :stack
    def initialize(stack)
      @stack = stack
    end
  end
end
