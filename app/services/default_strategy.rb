class DefaultStrategy
  def initialize(flash_cards, number_of_cards = 10)
    @flash_cards = flash_cards
    @number_of_cards = number_of_cards
  end

  def cards
    flash_cards.sample(length)
  end

  private

  attr_reader :flash_cards, :number_of_cards

  def length
    number_of_cards > flash_cards.length ? flash_cards.length : number_of_cards
  end

end
