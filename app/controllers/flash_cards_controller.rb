class FlashCardsController < ApplicationController
  def show
    flash_card = FlashCard.find(params[:id])

    render json: FlashCardSerializer.new(flash_card).to_json, status: :ok
  end
end
