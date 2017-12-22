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
end

