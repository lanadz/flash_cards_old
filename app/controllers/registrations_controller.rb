class RegistrationsController < ApplicationController
  skip_before_action :require_login

  def create
    user_repo = User::Repo.new(params: user_params).execute

    if user_repo.user.valid?
      CreateToken.new(user_repo.user).execute
      jwt_token = JWT.encode({ data: user_repo.user.auth_token }, ENV['JWT_SECRET'])

      render json: AuthorisationSerializer.new(user_repo.user, jwt_token).to_json, status: :created
    else
      render json: ErrorSerializer.new(user_repo.errors).to_json, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:registration).permit(:name, :email, :password)
  end
end
