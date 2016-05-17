require_relative 'router.rb'

class RFTG
  def self.call(env)
    request = Rack::Request.new(env)
    method = request.request_method

    headers = {
      'Content-Type' => 'text/html',
      'Set-Cookie' => "#{Router::SESSION}=#{Router::SESSION_ID}"
    }

    begin
      body = Router::Controller.select_body(env)
    rescue ArgumentError, TypeError, RangeError, IndexError => error
      status, body = Router::Controller.error(error.class)
    else
      status =
        if method == Router::Method::POST
          302
        else
          200
        end
    end

    response = Rack::Response.new(body, status, headers)
    response.finish
  end
end

run RFTG
