class DefaultStrategy
  def initialize(flash_cards, number_of_cards = 10)
    @flash_cards = flash_cards
    @number_of_cards = number_of_cards
    move_cards_to_boxes
  end

  def cards
    shuffle(length)
  end

  private

  attr_reader :flash_cards,
              :number_of_cards,
              :cards_box_0,
              :cards_box_1,
              :cards_box_2,
              :cards_box_3,
              :cards_box_4

  def shuffle(length)
    ENV.fetch('BOX1').to_f

    flash_cards.sample(length).map do |card|
      card.attributes.merge(
        "correct_times" => card.flash_card_show&.correct_times || 0,
        "show_times" => card.flash_card_show&.show_times || 0,
        "box" => card.flash_card_show&.box || 0
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
      @cards_box_0 << flash_card if flash_card.flash_card_show&.box.nil?
      @cards_box_1 << flash_card if flash_card.flash_card_show&.box == 1
      @cards_box_2 << flash_card if flash_card.flash_card_show&.box == 2
      @cards_box_3 << flash_card if flash_card.flash_card_show&.box == 3
      @cards_box_4 << flash_card if flash_card.flash_card_show&.box == 4
    end
  end

  def length
    number_of_cards > flash_cards.length ? flash_cards.length : number_of_cards
  end

end
