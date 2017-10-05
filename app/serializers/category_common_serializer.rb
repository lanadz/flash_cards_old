class CategoryCommonSerializer

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
        flash_card_ids: flash_cards.inject([]) {|ids, record| ids.push(record.id); ids}
      }
    }
  end

  alias_method :as_json, :to_json

  private

  attr_reader :name, :is_default, :flash_cards
end
