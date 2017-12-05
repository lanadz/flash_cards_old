class AuthorisationSerializer
  def initialize(user, jwt_token)
    @user = user
    @jwt_token = jwt_token
  end

  def to_json(options = {})
    {
      data: {
        user: {
          name: user.name,
          email: user.email,
        },
        token: {
          token: jwt_token,
          expires_at: user.auth_token_expired_at
        }
      }
    }
  end

  alias_method :as_json, :to_json

  private

  attr_reader :user, :jwt_token
end
