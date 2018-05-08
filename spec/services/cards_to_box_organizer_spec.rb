require 'rails_helper'

RSpec.describe CardsToBoxOrganizer do
  let(:card_0) { FlashCard::ValueObject.new(face: 'Box 0', box: 0, id: 1) }
  let(:card_1) { FlashCard::ValueObject.new(face: 'Box 1', box: 1, id: 2) }
  let(:card_2) { FlashCard::ValueObject.new(face: 'Box 2', box: 2, id: 3) }
  let(:card_3) { FlashCard::ValueObject.new(face: 'Box 3', box: 3, id: 4) }
  let(:card_4) { FlashCard::ValueObject.new(face: 'Box 4', box: 4, id: 5) }

  let(:cards) do
    [
      card_0,
      card_1,
      card_2,
      card_3,
      card_4
    ]
  end

  subject { described_class.new(cards) }

  describe '#initialize' do
    it "creates new instance" do
      subject
    end
  end

  describe '#organize' do
    it "moves cards to boxes" do
      subject.organize
      subject.each do |index, box|
        expect(box).to eq FlashCard::Box.new(cards: [eval("card_#{index}")], level: index)
      end
    end
  end
end
