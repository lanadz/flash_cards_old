class FlashCardsController < ApplicationController
  def create
    flash_card_creator = FlashCard::Creator.new
    flash_card_creator.create(params: flash_card_params, creator: current_user)
    if flash_card_creator.success
      render json: FlashCardSerializer.new(flash_card_creator.flash_card).to_json, status: :created
    else
      render json: ErrorSerializer.new(flash_card_creator.errors).to_json, status: :unprocessable_entity
    end
  end

  def destroy
    flash_card = current_user.flash_cards.find(params[:id])
    flash_card.destroy

    render json: {data: {message: 'Deleted'}}, status: :ok
  end

  private

  def flash_card_params
    params.require(:flash_card).permit(:face, :back, :category_id)
  end
end
