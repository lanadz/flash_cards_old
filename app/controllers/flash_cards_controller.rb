class FlashCardsController < ApplicationController
  def index
    flash_cards = current_user.flash_cards

    render json: FlashCardsSerializer.new(flash_cards).to_json
  end

  def show
    flash_card = current_user.flash_cards.find(params[:id])
    flash_card_show = FlashCardShow.find_by(user: current_user, flash_card: flash_card)

    render json: FlashCardSerializer.new(flash_card, flash_card_show).to_json
  end

  def create
    flash_card_repo = FlashCard::Repo.new.create(params: flash_card_params, creator: current_user)
    flash_card = flash_card_repo.flash_card
    if flash_card_repo.success
      render json: FlashCardSerializer.new(flash_card).to_json, status: :created
    else
      render json: ErrorSerializer.new(flash_card_repo.errors).to_json, status: :unprocessable_entity
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
