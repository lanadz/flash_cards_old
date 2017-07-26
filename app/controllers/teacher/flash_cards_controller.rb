module Teacher
  class FlashCardsController < ApplicationController
    def index
      @flash_cards = FlashCard.all

      render json: @flash_cards
    end

    def show
      @flash_card = FlashCard.find(params[:id])

      render json: @flash_card
    end

    def create
      @flash_card = FlashCard.new(flash_card_params)

      if @flash_card.save
        render json: @flash_card, status: :created, location: @flash_card
      else
        render json: @flash_card.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @flash_card = FlashCard.find(params[:id])
      @flash_card.destroy

      render :ok
    end

    private

    def flash_card_params
      params.require(:flash_card).permit(:face, :back)
    end
  end
end