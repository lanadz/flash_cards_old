class RegistrationsController < ApplicationController
  skip_before_action :require_login

  def create
    user = User.new(user_params)

    if user.save
      CreateToken.new(user).execute
      jwt_token = JWT.encode({ data: user.auth_token }, ENV['JWT_SECRET'])

      render json: AuthorisationSerializer.new(user, jwt_token).to_json, status: :created
    else
      render json: ErrorSerializer.new(user.errors).to_json, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:registration).permit(:name, :email, :password)
  end
end
