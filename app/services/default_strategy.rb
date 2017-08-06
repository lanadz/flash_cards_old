class DefaultStrategy
  def initialize(flash_cards)
    @flash_cards = flash_cards
  end

  def cards
    prepare(10)
  end

  private

  attr_reader :flash_cards

  def prepare(n)
    flash_cards.sample(amount(n))
  end

  def amount(n)
    length = flash_cards.length
    n > length ? length : n
  end
end
