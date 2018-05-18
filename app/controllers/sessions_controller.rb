class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create]

  def create
    user = User.find_by!(email: user_params[:email].downcase)

    raise ActiveRecord::RecordNotFound unless user.password == user_params[:password]

    CreateToken.new(user).execute
    jwt_token = JWT.encode({ data: user.auth_token }, ENV['JWT_SECRET'])

    render json: AuthorisationSerializer.new(user, jwt_token).to_json, status: :ok
  end

  def signout
    current_user.update_attributes!(auth_token: nil, auth_token_expired_at: nil)

    render json: {data: {message: 'Bye'}}, status: :ok
  end

  private

  def user_params
    params.require(:signin).permit(:password, :email)
  end
end
