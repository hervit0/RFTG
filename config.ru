require_relative 'router.rb'

class RFTG
  def self.call(env)
    status = 200
    headers = {"Content-Type" => "text/html"}
    body = Router.select_body(env)

    [status, headers, body]
  end
end

use Rack::Static,
  :urls => ['/css'],
  :root => '.'

run RFTG
