require 'rails_helper'

RSpec.describe CreateLearningSession do
  context 'one user' do
    let(:user) { create :user }
    let(:category) { create :category, user: user }
    let(:flash_card) { create :flash_card, user: user, category: category }
    let!(:flash_card_show) { create :flash_card_show,
                                    user: user,
                                    flash_card: flash_card,
                                    correct_times: 1,
                                    show_times: 1,
                                    box: 1 }
    subject { described_class.new(category, user) }
    it 'fetches flash cards' do
      dbl = double(LearningSessionDetail)
      expect(LearningSessionDetail).to receive(:create!).and_return(dbl)
      expect(subject.execute).to eq({
                                      learning_session_details: dbl,
                                      cards: [
                                        flash_card
                                          .attributes
                                          .merge({"correct_times" => 1, "show_times" => 1, "box" => 1})
                                      ]
                                    })
    end
  end

  context 'many users' do
    let(:user) { create :user }
    let(:another_user) { create :user }
    let(:category) { create :category, user: user }
    let(:flash_card) { create :flash_card, user: user, category: category }
    let!(:flash_card_show_another_user) { create :flash_card_show,
                                    user: user,
                                    flash_card: flash_card,
                                    correct_times: 12,
                                    show_times: 12,
                                    box: 4 }
    let!(:flash_card_show_original_user) { create :flash_card_show,
                                    user: another_user,
                                    flash_card: flash_card,
                                    correct_times: 1,
                                    show_times: 1,
                                    box: 1 }
    subject { described_class.new(category, another_user) }
    it 'fetches flash cards' do
      dbl = double(LearningSessionDetail)
      expect(LearningSessionDetail).to receive(:create!).and_return(dbl)
      expect(subject.execute).to eq({
                                      learning_session_details: dbl,
                                      cards: [
                                        flash_card
                                          .attributes
                                          .merge({"correct_times" => 1, "show_times" => 1, "box" => 1})
                                      ]
                                    })
    end
  end
end

