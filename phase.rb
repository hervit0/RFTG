class Phase
  attr_reader :order

  def initialize(order)
    @order = order
  end
  
  PHASES_NAMES = {
    1 => "explore",
    2 => "develop",
    3 => "settle",
    4 => "consume",
    5 => "produce"
  }

  def name
    PHASES_NAMES[@order]
  end
end
