class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  prepend_before_action :require_login

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def require_login
    render json: ({errors: {detail: 'Access denied'}}) && return unless signed_in?
  end

  def signed_in?
    current_user.present?
  end

  def current_user
    @_current_user ||= User.find_by(auth_token: token)
  end

  def token
    authenticate_or_request_with_http_token do |token, options|
      begin
        @token ||= JWT.decode(token, ENV.fetch('JWT_SECRET')).first['data']
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def record_not_found
    render json: {errors: {detail: 'Record not found'}}, status: :not_found
  end
end
