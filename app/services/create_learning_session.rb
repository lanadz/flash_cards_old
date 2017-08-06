class CreateLearningSession
  attr_reader :category, :flash_card_ids

  def initialize(category)
    @flash_card_ids = category.flash_cards.pluck(:id)
  end

  def current
    DefaultStrategy.new(flash_card_ids).cards
  end
end
