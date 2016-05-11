require 'mongo'

module Persistence
  class DatabaseConnection
    def self.from_id(id)
      host = ['127.0.0.1:27017']
      client = Mongo::Client.new(host)
    #  db = client["db_#{id}"]
      client.use("db_#{id}").database.fs
    end
  end
end
