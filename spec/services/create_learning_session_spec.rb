require 'rails_helper'

RSpec.describe CreateLearningSession do
  let(:user) { create :user }
  let(:category) { create :category, user: user }
  let(:flash_card) { create :flash_card, user: user, category: category }
  let!(:flash_card_show) { create :flash_card_show,
                                  user: user,
                                  flash_card: flash_card,
                                  correct_times: 0,
                                  show_times: 0 }
  subject { described_class.new(category, user) }
  it 'fetches flash cards' do
    dbl = double(LearningSessionDetail)
    expect(LearningSessionDetail).to receive(:create!).and_return(dbl)
    expect(subject.execute).to eq({
                                    learning_session_details: dbl,
                                    cards: [
                                      flash_card
                                        .attributes
                                        .merge({"correct_times" => 0, "show_times" => 0})
                                    ]
                                  })
  end
end

