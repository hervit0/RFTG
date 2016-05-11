require 'yaml'
require_relative 'mongo.rb'

module Persistence
  class Database
    def self.marshal_players_number(id, players_number)
      database = DatabaseConnection.from_id(id)
      database.upload_from_stream("#{id}.yml", players_number.to_yaml)
    end

    def self.unmarshal_players_number(id)
      database = DatabaseConnection.from_id(id)
      players_number = database.open_download_stream_by_name("#{id}.yml")
      YAML.load(players_number.read)
    end

    def self.marshal_state(id, state)
      database = DatabaseConnection.from_id(id)
      database.upload_from_stream("#{id}.yml", state.to_yaml)
    end

    def self.unmarshal_state(id)
      database = DatabaseConnection.from_id(id)
      state = database.open_download_stream_by_name("#{id}.yml")
      YAML.load(state.read)
    end
  end
end
