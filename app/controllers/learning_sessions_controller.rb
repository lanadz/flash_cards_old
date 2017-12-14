class LearningSessionsController < ApplicationController
  def create
    category = current_user.categories.find(params[:category_id])

    learning_session = CreateLearningSession.new(category)

    flash_cards = learning_session.current

    render json: FlashCardsSerializer.new(flash_cards).to_json
  end
end
