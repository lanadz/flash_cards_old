module Teacher
  class CategoriesController < ApplicationController
    def index
      categories = Category.all

      render json: CategoriesSerializer.new(categories).to_json, status: :ok
    end

    def show
      category = Category.find(params[:id])

      render json: CategoryWithCardsSerializer.new(category, category.flash_cards).to_json, status: :ok
    end

    def create
      category = Category.new(category_params)

      if category.save
        render json: CategorySerializer.new(category).to_json, status: :created
      else
        render json: @category.errors, status: :unprocessable_entity
      end
    end

    private

    def category_params
      params.require(:category).permit(:name)
    end
  end
end
