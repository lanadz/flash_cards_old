require 'rails_helper'

RSpec.describe UpdateFlashCardsShow do
  let(:user) { create :user }
  let(:category) { create :category, user: user }
  let(:flash_cards) { create_list :flash_card, 2, category: category, user: user }
  let(:flash_cards_params) do
    [
      {id: flash_cards.first.id, state: true},
      {id: flash_cards.last.id, state: false},
    ]
  end
  subject { described_class.new(flash_cards_params, user) }

  context 'First show of the cards' do
    describe '#execute' do
      it 'creates new entries flash card show and sets correct_times' do
        expect { subject.execute }.to change { FlashCardShow.count }.from(0).to(2)
        expect(FlashCardShow.find_by(flash_card_id: flash_cards.first.id).correct_times).to eq 1
        expect(FlashCardShow.find_by(flash_card_id: flash_cards.last.id).correct_times).to eq 0
        expect(FlashCardShow.find_by(flash_card_id: flash_cards.last.id).box).to eq 1
      end
    end
  end

  context 'Following shows of the cards' do
    describe '#execute' do
      it 'updates existing entries flash card show and sets correct_times and show time' do
        expect(FlashCardShow.count).to eq 0
        subject.execute
        expect(FlashCardShow.count).to eq 2
        subject.execute
        expect(FlashCardShow.count).to eq 2 # the number didn't change

        correct_answered_card = FlashCardShow.find_by(flash_card_id: flash_cards.first.id)
        expect(correct_answered_card.correct_times).to eq 2
        expect(correct_answered_card.show_times).to eq 2
        expect(correct_answered_card.box).to eq 2

        incorrect_answered_card = FlashCardShow.find_by(flash_card_id: flash_cards.last.id)
        expect(incorrect_answered_card.correct_times).to eq 0
        expect(incorrect_answered_card.show_times).to eq 2
        expect(incorrect_answered_card.box).to eq 1
      end
    end
  end
end

