require 'rails_helper'

RSpec.describe CreateLearningSession do
  let(:user1) { create :user }
  let(:user2) { create :user }
  let(:category) { create :category, user: user1 }
  let(:flash_card) { create :flash_card, creator: user1, category: category }
  let(:flash_card_show1) { create :flash_card_show,
                                 user: user1,
                                 flash_card: flash_card,
                                 correct_times: 1,
                                 show_times: 1,
                                 box: 1 }

  let(:flash_card_show2) { create :flash_card_show,
                                  user: user2,
                                  flash_card: flash_card,
                                  correct_times: 2,
                                  show_times: 2,
                                  box: 1 }

  let!(:cards) do
    [
      FlashCard::ValueObject.new(face: flash_card.face,
                                 back: flash_card.back,
                                 user_id: flash_card_show2.user_id,
                                 creator_id: flash_card.creator_id,
                                 show_times: flash_card_show2.show_times,
                                 correct_times: flash_card_show2.correct_times,
                                 category_id: flash_card.category_id,
                                 box: flash_card_show2.box,
                                 id: flash_card.id)
    ]
  end

  subject { described_class.new(category, user2) }
  it 'fetches flash cards' do
    dbl = double(LearningSessionDetail)
    expect(LearningSessionDetail).to receive(:create!).and_return(dbl)
    expect(subject.execute).to eq({
                                    learning_session_details: dbl,
                                    cards: cards
                                  })
  end
end

