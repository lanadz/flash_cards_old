class CardsToBoxOrganizer
  attr_reader :box_0, :box_1, :box_2, :box_3, :box_4

  alias_method :not_started, :box_0
  alias_method :mastered, :box_4

  def initialize(cards)
    @cards = cards
    @box_0 = FlashCard::Box.new(level: 0)
    @box_1 = FlashCard::Box.new(level: 1)
    @box_2 = FlashCard::Box.new(level: 2)
    @box_3 = FlashCard::Box.new(level: 3)
    @box_4 = FlashCard::Box.new(level: 4)
  end

  def organize
    @cards.each do |card|
      case card.box
      when 0
        @box_0.add(card)
      when 1
        @box_1.add(card)
      when 2
        @box_2.add(card)
      when 3
        @box_3.add(card)
      when 4
        @box_4.add(card)
      end
    end
  end
end
