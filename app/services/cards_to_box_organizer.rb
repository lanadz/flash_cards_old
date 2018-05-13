class CardsToBoxOrganizer
  attr_reader :cards, :boxes

  def initialize(cards)
    @cards = cards
    @box_0 = FlashCard::Box.new(level: 0)
    @box_1 = FlashCard::Box.new(level: 1)
    @box_2 = FlashCard::Box.new(level: 2)
    @box_3 = FlashCard::Box.new(level: 3)
    @box_4 = FlashCard::Box.new(level: 4)
    @boxes = {
      0 => @box_0,
      1 => @box_1,
      2 => @box_2,
      3 => @box_3,
      4 => @box_4,
    }
  end

  def each(&block)
    @boxes.each(&block)
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
    self
  end
end
