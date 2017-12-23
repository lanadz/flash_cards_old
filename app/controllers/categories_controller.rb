class CategoriesController < ApplicationController
  def index
    categories = current_user.categories

    render json: CategoriesSerializer.new(categories).to_json, status: :ok
  end

  def show
    category = current_user.categories.find(params[:id])
    details = LearningSessionDetailsForCategory.new(
      category.learning_session_details.where(user: current_user).order(started_at: :asc)
    ).execute

    render json: CategoryCommonSerializer.new(
      category: category,
      flash_cards: category.flash_cards,
      total_points: details.total_points,
      last_session_points: details.last_session_points
    ).to_json, status: :ok
  end

  def create
    category = current_user.categories.new(category_params)

    if category.save
      render json: CategorySerializer.new(category).to_json, status: :created
    else
      render json: ErrorSerializer.new(category.errors).to_json, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
