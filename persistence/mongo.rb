require 'mongo'
require 'yaml'

module Persistence
  class MongoStore
    def self.connection_from_id(id)
      host = ENV['MONGODB_URI'] || ['127.0.0.1:27017']

      Mongo::Client.new(host, database: 'rftg')
    end

    def self.save(state)
      collection = MongoStore.connection_from_id(id)
      collection.insert_one(state)
    end

    def self.read(id)
      collection = MongoStore.connection_from_id(id)
      collection.find.first
    end
  end

  class FileStore
    def self.save(id, state)
      File.write("#{id}.yml", state.to_yaml)
    end

    def self.read(id)
      YAML.load(File.read("#{id}.yml"))
    end
  end
end
