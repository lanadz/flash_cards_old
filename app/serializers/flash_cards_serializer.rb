class FlashCardsSerializer
  def initialize(flash_cards)
    @flash_cards = flash_cards
  end

  def to_json(options = {})
    {
      data: flash_cards.map { |record| {id: record.id, face: record.face, back: record.back} }
    }
  end

  alias_method :as_json, :to_json

  private

  attr_reader :flash_cards
end
