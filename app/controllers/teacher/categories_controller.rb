module Teacher
  class CategoriesController < ApplicationController
    def index
      @categories = Category.all

      render json: @categories
    end

    def show
      @category = Category.find(params[:id])

      render json: @category, serializer: CategoryWithCardsSerializer
    end

    def create
      @category = Category.new(category_params)

      if @category.save
        render json: @category, status: :created, location: [:teacher, @category]
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
