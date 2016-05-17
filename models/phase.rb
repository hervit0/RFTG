module Model
  class Phase
    attr_reader :order

    def initialize(order)
      @order = order
    end

    PHASES_NAMES = %w(explore develop settle consume produce).map(&:freeze)

    def name
      PHASES_NAMES[@order]
    end
  end
end
