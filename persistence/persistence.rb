require 'yaml'
require_relative 'mongo.rb'

module Persistence
  class Persistence
    def initialize(store)
      @store = store
    end

    def save_state(id, state)
      @store.save(id, state)
    end

    def read_state(id)
      @store.read(id)
    end
  end
end
