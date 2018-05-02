class FlashCard
  class Box
    include Comparable

    attr_reader :level, :cards

    def initialize(cards: [], level: 0)
      @cards = cards
      @level = level
    end

    def add(card)
      @cards << card
    end

    def take(amount)
      cards.sample(amount)
    end

    def has_cards?
      cards.present?
    end

    def ==(other)
      cards == other.cards && level == other.level
    end
  end
end
