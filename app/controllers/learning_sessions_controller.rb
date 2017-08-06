class LearningSessionsController < ApplicationController
  def create
    category = Category.find(params[:category_id])

    learning_session = CreateLearningSession.new(category)

    @flash_card_ids = learning_session.current

    render json: {flash_card_ids: @flash_card_ids}
  end
end
