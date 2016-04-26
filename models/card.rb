module Model
  class Card
    attr_reader :name, :id, :cost, :victory_points
    def initialize(name:, id:, cost:, victory_points:)
      @name = name
      @id = id
      @cost = cost
      @victory_points = victory_points
    end

    def display
      "#{@name} - Cost: #{@cost}, Points: #{@victory_points}"
    end
  end
end
