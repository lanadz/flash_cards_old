module Teacher
  class CategoriesController < ApplicationController
    def index
      @categories = Category.all

      render json: @categories
    end

    def show
      @category = Category.find(params[:id])
      @flash_cards = @category.flash_cards

      render json: @category
    end

    def create
      @category = Category.new(category_params)

      if @category.save
        render json: @category, status: :created, location: @category
      else
        render json: @category.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @category = Category.find(params[:id])
      @category.destroy

      render :ok
    end

    private

    def category_params
      params.require(:category).permit(:name)
    end
  end
end
