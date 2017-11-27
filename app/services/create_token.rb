class CreateToken
  attr_reader :jwt_token, :jwt_token_expiry_time
  def initialize(user)
    @user = user
  end

  def execute
    time = Time.current + ENV.fetch('TOKEN_EXPIRY', 3600).to_i
    user.update_attributes(
      auth_token: token,
      auth_token_expired_at: time
    )

    @jwt_token = JWT.encode({ data: token }, ENV['JWT_SECRET'])
    @jwt_token_expiry_time = time

    self
  end


  private

  attr_reader :user

  def token
    @token ||= SecureRandom.urlsafe_base64(32)
  end
end
