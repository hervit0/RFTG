class Card
  attr_accessor :name, :cost, :victory_points
  def initialize(name, cost, victory_points)
    @name = name
    @cost = cost
    @victory_points = victory_points
  end
end
