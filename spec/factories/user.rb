FactoryGirl.define do
  factory :user, class: User do
    name "User"
    password { SecureRandom.hex(10) }
    sequence(:email) { |n| "user_#{n}@mail.com" }
    sequence(:auth_token) { |n| "token_user_#{n}" }
    auth_token_expired_at Time.current + 3600
  end
end
