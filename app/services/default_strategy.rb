# 1. Take 10 cards from box 0, to promote them all eventually to box 1
# 2. If cannot take 10 cards from box 0, take the remaining amount from the box 1

class DefaultStrategy
  BOX_FIRST = 0
  BOX_LAST = 4

  def initialize(box_organizer, number_of_cards = 10)
    @box_organizer = box_organizer
    @number_of_cards_in_session = number_of_cards
  end

  def cards
    selected_cards = []
    number_of_needed_cards = @number_of_cards_in_session
    @box_organizer.each do |_box_number, box|
      cards = box.take(number_of_needed_cards)
      number_of_needed_cards = number_of_needed_cards - cards.size
      selected_cards.push(cards)
      break if number_of_needed_cards.zero?
    end

    selected_cards.flatten
  end
end
