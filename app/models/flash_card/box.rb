class FlashCard
  class Box
    attr_reader :level, :cards

    def initialize(cards: [], level: 0)
      @cards = cards
      @level = level
    end

    def take(amount)
      cards.sample(amount)
    end
  end
end
