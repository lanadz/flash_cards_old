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
    flash_card = current_user.flash_cards.new(flash_card_params).tap { |flash_crd| flash_crd.creator_id = current_user.id }

    if flash_card_params[:category_id].nil?
      flash_card.category = current_user.categories.find_by_is_default(true) || current_user.categories.create(name: "General", is_default: true)
    end

    if flash_card.save
      render json: FlashCardSerializer.new(flash_card).to_json, status: :created
    else
      render json: ErrorSerializer.new(flash_card.errors).to_json, status: :unprocessable_entity
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
