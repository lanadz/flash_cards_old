# 1. Take 10 cards from box 0, to promote them all eventually to box 1
# 2. If cannot take 10 cards from box 0, take the remaining amount from the box 1

class DefaultStrategy
  def initialize(boxes, number_of_cards = 10)
    @boxes = boxes
    @number_of_cards = number_of_cards
  end

  def cards
    shuffle
  end

  private

  def shuffle
    if @boxes.box_0.has_cards?
      @boxes.box_0.take(@number_of_cards)
    else
      @boxes.cards
    end
  end
end
