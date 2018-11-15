FactoryBot.define do
  factory :flash_card do
    face { "1+1" }
    back { "=2" }
    category
    association :creator, factory: :user
  end
end
