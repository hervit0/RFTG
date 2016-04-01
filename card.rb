class Card
  attr_reader :name, :cost, :victory_points
  def initialize(name, cost, victory_points)
    @name = name
    @cost = cost
    @victory_points = victory_points
  end

  def display
    "#{@name} - Cost: #{@cost}, Points: #{@victory_points}"
  end
end
