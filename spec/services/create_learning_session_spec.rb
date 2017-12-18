require 'rails_helper'

RSpec.describe CreateLearningSession do
  let(:user) { create :user }
  let(:category) { create :category, user: user }
  let!(:flash_card) { create :flash_card, user: user, category: category }
  subject { described_class.new(category, user) }
  it 'fetches flash cards' do
    dbl = double(LearningSessionDetail)
    expect(LearningSessionDetail).to receive(:create!).and_return(dbl)
    expect(subject.execute).to eq({
                                    learning_session_details: dbl,
                                    cards: [flash_card]
                                  })
  end
end

