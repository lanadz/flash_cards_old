class CreateLearningSession
  def initialize(category, user)
    @category = category
    @user = user
  end

  def execute
    flash_cards = FlashCard::Finder.new(user: @user).find_by(category_id: @category.id)
    cards = DefaultStrategy.new(flash_cards).cards
    {
      learning_session_details: LearningSessionDetail.create!(
        user: @user,
        category: @category,
        started_at: Time.current,
        cards_amount: cards.length
      ),
      cards: cards
    }
  end
end
