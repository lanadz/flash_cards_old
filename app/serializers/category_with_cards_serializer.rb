class CategoryWithCardsSerializer

  def initialize(category, flash_cards)
    @name = category.name
    @is_default = category.is_default
    @flash_cards = flash_cards
  end

  def to_json(options = {})
    {
      data: {
        name: name,
        is_default: is_default,
        flash_cards: flash_cards.map { |record| {face: record.face, back: record.back} }
      }
    }
  end

  alias_method :as_json, :to_json

  private

  attr_reader :name, :is_default, :flash_cards
end
