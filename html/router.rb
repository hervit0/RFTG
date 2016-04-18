require_relative 'welcome.rb'
require_relative 'names.rb'
require_relative 'discard.rb'

class Router
  def self.select_body(env)
    request = Rack::Request.new(env)
    method = request.request_method
    url = request.url

    p method
    p url
    p request.POST

    if url == "http://rftg/players_names" && method == "POST"
      player_number = request.POST.values.first.to_i
      Names.new(player_number).give_name
    elsif url == "http://rftg/discard" && method == "POST"
      names = request.POST.values
      p names
      Discard.new(names[0]).discard_cards
    else
      Welcome.display
    end
  end
end
