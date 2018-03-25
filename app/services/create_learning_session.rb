class CreateLearningSession
  def initialize(category, user)
    @category = category
    @user = user
  end

  def execute
    flash_cards_with_shows = flash_cards.includes(:flash_card_shows)#.where('flash_cards_shows.user_id': user.id)

    cards = DefaultStrategy.new(flash_cards_with_shows).cards

    {
      learning_session_details: LearningSessionDetail.create!(
        user: user,
        category: category,
        started_at: Time.current,
        cards_amount: cards.length
      ),
      cards: cards
    }
  end

  private

  attr_reader :category, :user

  def flash_cards
    @flash_cards ||= category.flash_cards
  end
end
