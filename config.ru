require_relative 'router.rb'
require 'pry'

class RFTG
  def self.call(env)
    request = Rack::Request.new(env)
    method = request.request_method

    status = method == "POST" ? 302 : 200

    headers = {"Content-Type" => "text/html", "Set-Cookie" => "#{Router::SESSION}=#{Router::SESSION_ID}"}
    body = Router::Controller.select_body(env)

    response = Rack::Response.new(body, status, headers)
    response.finish
  end
end

use Rack::Static,
  :urls => ['/css'],
  :root => '.'

run RFTG
