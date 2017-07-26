module Teacher
  class FlashCardsController < ApplicationController
    before_action :set_flash_card, only: [:show, :update, :destroy]

    def index
      @flash_cards = FlashCard.all

      render json: @flash_cards
    end

    def show
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
      @flash_card.destroy
    end

    private
    def set_flash_card
      @flash_card = FlashCard.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def flash_card_params
      params.fetch(:flash_card, {}).permit(:face, :back)
    end
  end
end
