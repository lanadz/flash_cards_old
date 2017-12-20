class LearningSessionsController < ApplicationController
  def create
    category = current_user.categories.find(params[:category_id])

    learning_session = CreateLearningSession.new(category, current_user).execute

    render json: LearningSessionSerializer.new(learning_session).to_json
  end

  def update
    learning_session_detail = current_user.learning_session_details.find(params[:id])
    learning_session_detail.update!(
      learning_session_detail_params.merge(finished_at: Time.current)
    )
    render json: {data: {message: 'Updated'}}, status: :ok
  end

  private

  def learning_session_detail_params
    params.require(:learning_session_detail).permit(:correct_answers, :wrong_answers)
  end
end
