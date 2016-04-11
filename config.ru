require_relative 'board.rb'
require_relative 'card.rb'

class RFTG
  def self.call(env)
    board = Board.new(Stack.from_cards(CARDS))
    names = board.stack.cards.map{ |x| x.name}

    status = 200
    headers = {"Content-Type" => "text/plain"}
    body = names

    [status, headers, body]
  end
end

run RFTG
