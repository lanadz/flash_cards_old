class SessionsController < ApplicationController
  skip_before_action :require_login

  def create
    user = User.find_by!(email: user_params[:email])

    raise ActiveRecord::RecordNotFound unless user.password == user_params[:password]

    CreateToken.new(user).execute
    jwt_token = JWT.encode({ data: user.auth_token }, ENV['JWT_SECRET'])

    render json: AuthorisationSerializer.new(user, jwt_token).to_json, status: :ok
  end

  private

  def user_params
    params.require(:signin).permit(:password, :email)
  end
end
