require 'rails_helper'

RSpec.describe DefaultStrategy do
  let(:user) { create :user}
  let(:category) { create :category, user: user }
  subject { described_class.new(flash_cards, 2) }

  describe '#cards' do

    context 'initially there are less than designed number of cards' do
      let(:flash_card) { create(:flash_card, user: user, category: category) }
      let(:flash_cards) { [flash_card] }
      let(:cards_response) do
        [flash_card
           .attributes
           .merge(
             "correct_times" => 0,
             "show_times" => 0,
             "box" => 0
           )
        ]
      end

      it 'fetches 1 flash card only' do
        expect(subject.cards).to eq cards_response
      end
    end

    context 'initially there are more than designed number of cards' do
      let(:flash_cards) { create_list(:flash_card, 3, user: user, category: category) }

      it 'fetches designed number of flash cards only' do
        expect(subject.cards.length).to eq 2
      end
    end

    context 'move cards to boxes correctly' do
      let(:card_box_0) do
        flash_card = build :flash_card, id: 1, user: user, category: category
        flash_card.stub_chain(:flash_card_show, :box).and_return(nil)
        flash_card
      end

      let(:card_box_1) do
        flash_card = build :flash_card, id: 2, user: user, category: category
        flash_card.stub_chain(:flash_card_show, :box).and_return(1)
        flash_card
      end

      let(:card_box_2) do
        flash_card = build :flash_card, id: 3, user: user, category: category
        flash_card.stub_chain(:flash_card_show, :box).and_return(2)
        flash_card
      end

      let(:card_box_3) do
        flash_card = build :flash_card, id: 4, user: user, category: category
        flash_card.stub_chain(:flash_card_show, :box).and_return(3)
        flash_card
      end

      let(:card_box_4) do
        flash_card = build :flash_card, id: 5, user: user, category: category
        flash_card.stub_chain(:flash_card_show, :box).and_return(4)
        flash_card
      end

      let(:boxed_flash_cards) {[card_box_0,card_box_1,card_box_2,card_box_3,card_box_4]}

      describe '#new' do
        subject { described_class.new(boxed_flash_cards) }
        it '#move_cards_to_boxes' do
          expect(subject.send(:cards_box_0)).to eq [card_box_0]
          expect(subject.send(:cards_box_1)).to eq [card_box_1]
          expect(subject.send(:cards_box_2)).to eq [card_box_2]
          expect(subject.send(:cards_box_3)).to eq [card_box_3]
          expect(subject.send(:cards_box_4)).to eq [card_box_4]
        end
      end
    end
  end

end
