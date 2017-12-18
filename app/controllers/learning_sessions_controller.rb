class LearningSessionsController < ApplicationController
  def create
    category = current_user.categories.find(params[:category_id])

    learning_session = CreateLearningSession.new(category, current_user).execute

    render json: LearningSessionSerializer.new(learning_session).to_json
  end
end
