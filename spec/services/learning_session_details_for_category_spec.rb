require 'rails_helper'

RSpec.describe LearningSessionDetailsForCategory do
  let(:user) { create :user }
  let(:category) { create :category, user: user }
  let!(:learning_session_details) { create_list :learning_session_detail, 5, user: user, category: category, wrong_answers: 1, correct_answers: 2, cards_amount: 3 }
  subject { described_class.new(learning_session_details) }

  describe '#total_points' do
    it 'returns total points' do
      subject.execute
      expect(subject.total_points).to eq 10
    end
  end

  describe '#last_points' do
    it 'returns total points' do
      last_session = create(:learning_session_detail, user: user, category: category, wrong_answers: 0, correct_answers: 3, cards_amount: 3)
      learning_session_details.push(last_session)
      subject.execute
      expect(subject.last_session_points).to eq last_session.correct_answers
    end
  end
end

