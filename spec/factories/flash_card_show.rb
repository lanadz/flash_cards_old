FactoryGirl.define do
  factory :flash_card_show do
    correct_times 1
    show_times 1
    box 1
    flash_card
    user
  end
end
