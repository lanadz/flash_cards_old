class CategoriesController < ApplicationController
  def index
    categories = Category.all

    render json: CategoriesSerializer.new(categories).to_json, status: :ok
  end

  def show
    category = Category.find(params[:id])

    render json: CategoryWithCardsSerializer.new(category, category.flash_cards).to_json, status: :ok
  end
end
