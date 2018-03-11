class CreateLearningSession
  def initialize(category, user)
    @category = category
    @user = user
  end

  def execute
    flash_card_shows = FlashCardShow.where(user: user).where(flash_card: flash_cards)
    cards = flash_cards.map do |card|
      result = flash_card_shows.find { |flash_card_show| card.id == flash_card_show.flash_card_id }
      card.attributes.merge(
        "correct_times" => result&.correct_times || 0,
        "show_times" => result&.show_times || 0,
        "box" => result&.box || 0
      )
    end

    combined_cards = DefaultStrategy.new(cards).cards
    {
      learning_session_details: LearningSessionDetail.create!(
        user: user,
        category: category,
        started_at: Time.current,
        cards_amount: cards.length
      ),
      cards: combined_cards
    }
  end

  private

  attr_reader :category, :user

  def flash_cards
    @flash_cards ||= category.flash_cards
  end
end
