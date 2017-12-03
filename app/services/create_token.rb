class CreateToken
  def initialize(user)
    @user = user
  end

  def execute
    time = Time.current + ENV.fetch('TOKEN_EXPIRY', 3600).to_i
    begin
    user.update_attributes(
      auth_token: token,
      auth_token_expired_at: time
    )
    rescue ActiveRecord::RecordNotUnique
      retry
    end
  end

  private

  attr_reader :user

  def token
    SecureRandom.urlsafe_base64(32)
  end
end
