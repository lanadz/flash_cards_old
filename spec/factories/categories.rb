FactoryBot.define do
  factory :category do
    name "English"
    is_default false
    user
  end
end
