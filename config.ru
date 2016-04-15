require_relative 'board.rb'
require_relative 'card.rb'
require_relative 'html/welcome.rb'
require_relative 'html/names.rb'

class RFTG
  def self.call(env)
    status = 200
    headers = {"Content-Type" => "text/html"}
    body = [Welcome.display]

    [status, headers, body]
  end
end

use Rack::Static,
  :urls => ['/css'],
  :root => '.'

run RFTG