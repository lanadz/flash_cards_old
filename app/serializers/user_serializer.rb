class UserSerializer
  def initialize(user, return_token: false)
    @user = user
    @return_token = return_token
  end

  def to_json(options = {})
    json = {
      data: {
        name: user.name,
        email: user.email,
        role: user.role
      }
    }

    if return_token
      json[:token] = {
        token: CreateToken.new(user).execute.jwt_token,
        expires_at: user.auth_token_expired_at
      }
    end

    json
  end

  alias_method :as_json, :to_json

  private

  attr_reader :user, :return_token
end
