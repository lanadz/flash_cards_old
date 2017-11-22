FactoryGirl.define do
  factory :student, class: User do
    name "Student"
    password { SecureRandom.hex(10) }
    email 'student@mail.com'
    role { :student }
    auth_token "token_student"
    auth_token_expired_at Time.current + 3600
  end

  factory :tutor, class: User do
    name "Tutor"
    password { SecureRandom.hex(10) }
    email 'tutor@mail.com'
    role { :tutor }
    auth_token "token_tutor"
    auth_token_expired_at Time.current + 3600
  end
end
