class LearningSessionsController < ApplicationController
  def create
    category = Category.find(params[:category_id])
    @flash_card_ids = category.flash_cards.pluck(:id)

    render json: {flash_card_ids: @flash_card_ids}
  end
end
