FactoryGirl.define do
  factory :user, class: User do
    name "User"
    password { SecureRandom.hex(10) }
    email 'user@mail.com'
    auth_token "token_user"
    auth_token_expired_at Time.current + 3600
  end
end
