class SessionsController < ApplicationController
  skip_before_action :require_login

  def create
    user = User.find_by!(email: user_params[:email])

    raise ActiveRecord::RecordNotFound unless user.password == user_params[:password]

    render json: UserSerializer.new(user, return_token: true).to_json, status: :ok
  end

  private

  def user_params
    params.require(:signin).permit(:password, :email)
  end
end
