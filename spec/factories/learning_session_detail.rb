FactoryBot.define do
  factory :learning_session_detail do
    correct_answers nil
    wrong_answers nil
    cards_amount nil
    category
    user
  end
end
