class RegistrationsController < ApplicationController
  skip_before_action :require_login

  def create
    user = User.new(user_params)

    if user.save
      render json: UserSerializer.new(user, return_token: true).to_json, status: :created
    else
      render json: ErrorSerializer.new(user.errors).to_json, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:registration).permit(:name, :email, :role, :password)
  end
end
