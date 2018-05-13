require 'rails_helper'

RSpec.describe DefaultStrategy do
  subject { described_class.new(box_organizer, 5).cards }
  let(:box_organizer) { CardsToBoxOrganizer.new(cards).organize }

  let(:cards_for_box_0) do
    (0...5).map do |index|
      FlashCard::ValueObject.new(box: 0, id: index)
    end
  end

  let(:cards_for_box_1) do
    (5...10).map do |index|
      FlashCard::ValueObject.new(box: 1, id: index)
    end
  end

  let(:cards_for_box_2) do
    (10...15).map do |index|
      FlashCard::ValueObject.new(box: 2, id: index)
    end
  end

  let(:cards_for_box_3) do
    (15...20).map do |index|
      FlashCard::ValueObject.new(box: 3, id: index)
    end
  end

  let(:cards_for_box_4) do
    (20...25).map do |index|
      FlashCard::ValueObject.new(box: 4, id: index)
    end
  end


  describe '#cards' do
    let(:cards) { cards_for_box_0 + cards_for_box_1 + cards_for_box_2 + cards_for_box_3 + cards_for_box_4 }

    context 'there are enough cards in box 0' do
      it 'selects cards from box 0' do
        expect(subject).to match_array cards_for_box_0
      end
    end

    context 'selects all possible number of cards from box 0 and continue with box 1' do
      let(:cards_for_box_0) do
        (0...3).map do |index|
          FlashCard::ValueObject.new(box: 0, id: index)
        end
      end
      let(:cards) { cards_for_box_0 + cards_for_box_1 + cards_for_box_4 }
      it 'selects cards' do
        expect(subject.size).to eq(5)
        expect(subject).to include(*cards_for_box_0)
        cards_selected_from_box1 = subject - cards_for_box_0
        cards_selected_from_box1.each do |card|
          expect(cards_for_box_1).to include(card)
        end
      end
    end

    context 'selects all possible number of cards from box 1 because there no cards in box 0 and continue with box 2 and then from 3 and so on' do
      let(:cards_for_box_0) do
        []
      end

      let(:cards_for_box_1) do
        [FlashCard::ValueObject.new(box: 1, id: 1)]
      end

      let(:cards_for_box_2) do
        (2..3).map do |index|
          FlashCard::ValueObject.new(box: 2, id: index)
        end
      end

      let(:cards_for_box_3) do
        [FlashCard::ValueObject.new(box: 3, id: 4)]
      end

      let(:cards_for_box_4) do
        [FlashCard::ValueObject.new(box: 4, id: 5)]
      end

      let(:cards) { cards_for_box_0 + cards_for_box_1 + cards_for_box_2 + cards_for_box_3 + cards_for_box_4 }
      it 'selects cards' do
        expect(subject.size).to eq(5)
        expect(subject).to include(*cards_for_box_0)
        expect(subject).to include(*cards_for_box_1)
        expect(subject).to include(*cards_for_box_2)
        expect(subject).to include(*cards_for_box_3)
        expect(subject).to include(*cards_for_box_4)
      end
    end
  end
end
