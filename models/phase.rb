module Model
  class Phase
    attr_reader :order

    def initialize(order)
      @order = order
    end

    PHASES_NAMES = ["explore", "develop", "settle", "consume", "produce"]

    def name
      PHASES_NAMES[@order]
    end
  end
end
