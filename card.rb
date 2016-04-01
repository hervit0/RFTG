class Card

  def initialize(name, cost, victory_points)
    @name = name
    @cost = cost
    @victory_points = victory_points
  end

  def display_card
    p @name
    p @cost
    p @victory_points
  end

end
