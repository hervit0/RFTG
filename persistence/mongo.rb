require 'mongo'
require 'yaml'

module Persistence
  class MongoStore
    def self.connection_from_id(id)
      host = ENV['MONGODB_URI'] || ['127.0.0.1:27017']

      client = Mongo::Client.new(host)
      client.use("db_#{id}").database.fs
    end

    def self.save(id, state)
      collection = MongoStore.connection_from_id(id)
      collection.upload_from_stream("#{id}.yml", state.to_yaml)
    end

    def self.read(id)
      collection = MongoStore.connection_from_id(id)
      state = collection.open_download_stream_by_name("#{id}.yml")
      YAML.load(state.read)
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
