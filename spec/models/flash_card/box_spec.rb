require 'rails_helper'

RSpec.describe FlashCard::Box do
  let(:cards) { [] }
  let(:level) { 0 }

  subject { described_class.new(cards: cards, level: level) }
  context 'Empty box' do
    describe '#initialize' do
      it 'creates card and related card show for current user' do
        expect(subject.cards).to eq cards
        expect(subject.level).to eq level
      end
    end

    describe '#take' do
      it 'creates card and related card show for current user' do
        expect(subject.take(10)).to eq []
      end
    end
  end

  context 'Box with cards' do
    let(:cards) do
      (0..20).map do |index|
        FlashCard::ValueObject.new(face: "Face #{index}",
                                   back: "Back #{index}",
                                   user_id: 1,
                                   creator_id: 1,
                                   show_times: 0,
                                   correct_times: 0,
                                   category_id: 1,
                                   box: 0,
                                   id: index)

      end
    end

    describe '#initialize' do
      it 'creates card and related card show for current user' do
        expect(subject.cards).to eq cards
        expect(subject.level).to eq level
      end
    end

    describe '#take' do
      it 'creates card and related card show for current user' do
        expect(cards).to include(*subject.take(10))
      end
    end

    describe '#add' do
      it 'adds card to box' do
        card = FlashCard::ValueObject.new(face: "Face 21", box: 0, id: 22)
        expect{subject.add(card)}.to change{subject.cards.count}.by 1
        expect(subject.cards).to include card
      end
    end

    describe '#has_cards?' do
      context 'there are cards' do
        it 'returns true' do
          expect(subject.has_cards?).to be_truthy
        end
      end

      context 'there are no cards' do
        let(:cards) { [] }
        it 'returns false' do
          expect(subject.has_cards?).to be_falsey
        end
      end
    end
  end
end
