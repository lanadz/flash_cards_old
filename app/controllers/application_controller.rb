class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  class UnauthorizedException < StandardError
  end

  prepend_before_action :require_login

  rescue_from ActiveRecord::RecordNotFound do
    render json: {errors: [{detail: 'Record not found'}]}, status: :not_found
  end

  rescue_from UnauthorizedException do
    render json: ({errors: {detail: 'Access denied'}}), status: 401
  end

  def require_login
    unless signed_in?
      raise UnauthorizedException
    end
  end

  def signed_in?
    current_user.present?
  end

  def current_user
    current_token = token

    if current_token.nil?
      raise UnauthorizedException
    end

    @_current_user ||= User.find_by(auth_token: current_token)
  end


  private

  def token
    authenticate_with_http_token do |token, options|
      begin
        JWT.decode(token, ENV.fetch('JWT_SECRET')).first['data']
      rescue JWT::DecodeError
        nil
      end
    end
  end
end
