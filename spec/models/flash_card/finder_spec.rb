require 'rails_helper'

RSpec.describe FlashCard::Finder do
  let(:user) { create :user, auth_token: 'token1', email: 'user1@a' }
  let(:user2) { create :user, auth_token: 'token2', email: 'user2@a' }
  let(:category) { create :category, user: user }
  let(:flash_card) { create :flash_card, category: category, creator: user }
  let!(:flash_card_show_1) { create :flash_card_show, correct_times: 1, show_times: 1, box: 1, flash_card: flash_card, user: user }
  let!(:flash_card_show_2) { create :flash_card_show, correct_times: 2, show_times: 3, box: 2, flash_card: flash_card, user: user2 }
  let(:result) do
    [
      FlashCard::ValueObject.new(face: flash_card.face,
                                 back: flash_card.back,
                                 user_id: user2.id,
                                 creator_id: user.id,
                                 show_times: flash_card_show_2.show_times,
                                 correct_times: flash_card_show_2.correct_times,
                                 category_id: category.id,
                                 box: flash_card_show_2.box,
                                 id: flash_card.id)
    ]
  end

  subject { described_class.new(user: user2) }
  describe '#find_by' do
    context 'returns empty set' do
      let(:params) { {category_id: category.id + 1} }
      it 'finds by card id' do
        expect(subject.find_by(params)).to eq []
      end
    end
    context 'returns set' do
      let(:params) { {category_id: category.id} }
      it 'finds by card id' do
        expect(subject.find_by(params)).to eq result
      end
    end
  end
end

