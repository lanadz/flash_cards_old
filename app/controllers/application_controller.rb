class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include RenderConcern

  prepend_before_action :require_login!

  def require_login!
    render_unauthorized({errors: {detail: "Access denied"}}) && return unless signed_in?
  end

  def signed_in?
    current_user.present?
  end

  def current_user
    @_current_user ||= token
  end

  def token
    authenticate_or_request_with_http_token do |token, options|
      User.find_by(auth_token: token)
    end
  end
end
