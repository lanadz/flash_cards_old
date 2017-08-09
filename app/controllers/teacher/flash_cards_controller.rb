module Teacher
  class FlashCardsController < ApplicationController
    def index
      flash_cards = FlashCard.all

      render json: FlashCardsSerializer.new(flash_cards).to_json
    end

    def show
      flash_card = FlashCard.find(params[:id])

      render json: FlashCardSerializer.new(flash_card).to_json
    end

    def create
      flash_card = FlashCard.new(flash_card_params)
      if flash_card.category_id.nil?
        flash_card.category = Category.find_by_is_default(true)
      end

      if flash_card.save
        render json: FlashCardSerializer.new(flash_card).to_json, status: :created
      else
        render json: ErrorSerializer.new(flash_card.errors).to_json, status: :unprocessable_entity
      end
    end

    def destroy
      flash_card = FlashCard.find(params[:id])
      flash_card.destroy

      render :ok
    end

    private

    def flash_card_params
      params.require(:flash_card).permit(:face, :back, :category_id)
    end
  end
end
