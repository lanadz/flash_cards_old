class CreateLearningSession
  attr_reader :category, :flash_cards

  def initialize(category)
    @flash_cards = category.flash_cards
  end

  def current
    DefaultStrategy.new(flash_cards).cards
  end
end
