# 1. Take 10 cards from box 0, to promote them all eventually to box 1
# 2. If cannot take 10 cards from box 0, take the remaining amount from the box 1

class DefaultStrategy
  def initialize(flash_cards, number_of_cards = 10)
    @flash_cards = flash_cards
    @number_of_cards = number_of_cards
    move_cards_to_boxes
  end

  def cards
    mixin_flash_card_show_info(shuffle)
  end

  private

  attr_reader :flash_cards,
              :number_of_cards,
              :cards_box_0,
              :cards_box_1,
              :cards_box_2,
              :cards_box_3,
              :cards_box_4

  def shuffle
    if cards_box_0.present?
      cards_box_0.sample(number_of_cards)
    else
      flash_cards.sample(number_of_cards)
    end
  end

  def mixin_flash_card_show_info(cards)
    cards.map do |card|
      card.attributes.merge(
        "correct_times" => card.flash_card_shows&.first&.correct_times || 0,
        "show_times" => card.flash_card_shows&.first&.show_times || 0,
        "box" => card.flash_card_shows&.first&.box || 0
      )
    end
  end

  def move_cards_to_boxes
    @cards_box_0 = Array.new
    @cards_box_1 = Array.new
    @cards_box_2 = Array.new
    @cards_box_3 = Array.new
    @cards_box_4 = Array.new
    flash_cards.each do |flash_card|
      @cards_box_0 << flash_card if flash_card.flash_card_shows.first&.box.nil?
      @cards_box_1 << flash_card if flash_card.flash_card_shows.first&.box == 1
      @cards_box_2 << flash_card if flash_card.flash_card_shows.first&.box == 2
      @cards_box_3 << flash_card if flash_card.flash_card_shows.first&.box == 3
      @cards_box_4 << flash_card if flash_card.flash_card_shows.first&.box == 4
    end
  end

  def cards_number_for_box(box_number)
    if box_number < ENV.fetch('BOX_NUMBER')
      (number_of_cards * ENV.fetch("BOX#{box_number}").to_f).floor
    else
      1
    end
  end
end
