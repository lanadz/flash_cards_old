class LearningSessionsController < ApplicationController
  def create
    category = Category.find(params[:category_id])

    learning_session = CreateLearningSession.new(category)

    flash_card_ids = learning_session.current

    json =
      if params[:include].present? && params[:include].include?('flash_card')
        flash_card = FlashCard.find(flash_card_ids.first)
        {data: {flash_card_ids: flash_card_ids, flash_card: FlashCardSerializer.new(flash_card)}}
      else
        {data: {flash_card_ids: flash_card_ids}}
      end

    render json: json
  end
end
