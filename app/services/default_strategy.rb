class DefaultStrategy
  def initialize(flash_cards, number_of_cards = 10)
    @flash_cards = flash_cards
    @number_of_cards = number_of_cards
  end

  def cards
    shuffle(length)
  end

  private

  attr_reader :flash_cards, :number_of_cards

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

  def length
    number_of_cards > flash_cards.length ? flash_cards.length : number_of_cards
  end

end
