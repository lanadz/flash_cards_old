require 'rails_helper'

RSpec.describe CreateLearningSession do
  # context 'one user' do
  #   let(:user) { create :user }
  #   let(:category) { create :category, user: user }
  #   let(:flash_card) { create :flash_card, user: user, category: category }
  #   let!(:flash_card_show) { create :flash_card_show,
  #                                   user: user,
  #                                   flash_card: flash_card,
  #                                   correct_times: 1,
  #                                   show_times: 1,
  #                                   box: 1 }
  #   subject { described_class.new(category, user) }
  #   it 'fetches flash cards' do
  #     dbl = double(LearningSessionDetail)
  #     expect(LearningSessionDetail).to receive(:create!).and_return(dbl)
  #     expect(subject.execute).to eq({
  #                                     learning_session_details: dbl,
  #                                     cards: [
  #                                       flash_card
  #                                         .attributes
  #                                         .merge({"correct_times" => 1, "show_times" => 1, "box" => 1})
  #                                     ]
  #                                   })
  #   end
  # end

  # context 'many users' do
  #   let(:user) { create :user }
  #   let(:another_user) { create :user }
  #   let(:category) { create :category, user: user }
  #   let(:flash_card) { create :flash_card, user: user, category: category }
  #   let!(:flash_card_show_another_user) { create :flash_card_show,
  #                                   user: user,
  #                                   flash_card: flash_card,
  #                                   correct_times: 12,
  #                                   show_times: 12,
  #                                   box: 4 }
  #   let!(:flash_card_show_original_user) { create :flash_card_show,
  #                                   user: another_user,
  #                                   flash_card: flash_card,
  #                                   correct_times: 1,
  #                                   show_times: 1,
  #                                   box: 1 }
  #   subject { described_class.new(category, another_user) }
  #   it 'fetches flash cards' do
  #     dbl = double(LearningSessionDetail)
  #     expect(LearningSessionDetail).to receive(:create!).and_return(dbl)
  #     expect(subject.execute).to eq({
  #                                     learning_session_details: dbl,
  #                                     cards: [
  #                                       flash_card
  #                                         .attributes
  #                                         .merge({"correct_times" => 1, "show_times" => 1, "box" => 1})
  #                                     ]
  #                                   })
  #   end
  let(:user) { create :user }
  let(:category) { create :category, user: user }
  let(:flash_card) { create :flash_card, creator: user, category: category }
  let(:flash_card_show) { create :flash_card_show,
                                 user: user,
                                 flash_card: flash_card,
                                 correct_times: 1,
                                 show_times: 1,
                                 box: 1 }
  let!(:cards) do
    [
      FlashCard::ValueObject.new(face: flash_card.face,
                                 back: flash_card.back,
                                 user_id: flash_card_show.user_id,
                                 creator_id: flash_card.creator_id,
                                 show_times: flash_card_show.show_times,
                                 correct_times: flash_card_show.correct_times,
                                 category_id: flash_card.category_id,
                                 box: flash_card_show.box,
                                 id: flash_card.id)
    ]
  end

  subject { described_class.new(category, user) }
  it 'fetches flash cards' do
    dbl = double(LearningSessionDetail)
    expect(LearningSessionDetail).to receive(:create!).and_return(dbl)
    expect(subject.execute).to eq({
                                    learning_session_details: dbl,
                                    cards: cards
                                  })
  end
end

