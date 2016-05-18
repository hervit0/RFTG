require_relative 'router.rb'

class RFTG
  def self.call(env)
    request = Rack::Request.new(env)
    method = request.request_method

    begin
      headers = Router::Controller.define_headers
      body = Router::Controller.select_body(env)
    rescue ArgumentError, TypeError, RangeError, IndexError => error
      status, body = Router::Controller.error(error.class)
    else
      status = Router::Controller.select_status(method)
    end

    response = Rack::Response.new(body, status, headers)
    response.finish
  end
end

run RFTG
