require_relative 'router.rb'
require 'pry'

class RFTG
  def self.call(env)
    status = 200
    headers = {"Content-Type" => "text/html", "Set-Cookie" => "session=rftg1"}
    body = Router.select_body(env)

    response = Rack::Response.new(body, status, headers)
    response.finish
  end
end

use Rack::Static,
  :urls => ['/css'],
  :root => '.'

run RFTG
