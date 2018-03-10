# All cards |
# start here|
#   BOX 0   |    BOX 1   |    BOX 2   |    BOX 3   |    BOX 4   |
#     |            |           |             |             |
#     |____________^           X             X             X
#                  |___________|_____________|_____________|
#                         On mistake card is back to BOX 1
#

require 'rails_helper'

RSpec.describe BoxPromoter do
  subject { described_class.new(current_box: current_box, is_promoted: is_promoted) }

  context "First show" do
    let(:current_box) { 0 }

    describe '#execute with correct answer' do
      let(:is_promoted) { true }
      it 'sets card box to be equal 1 on first show' do
        subject.promote
        expect(subject.result).to eq 1
      end
    end

    describe '#execute with incorrect answer' do
      let(:is_promoted) { false }
      it 'sets card box to be equal 1 on first show' do
        subject.promote
        expect(subject.result).to eq 1
      end
    end
  end

  context "Second show" do
    let(:current_box) { 1 }
    describe '#execute with correct answer' do
      let(:is_promoted) { true }
      it 'sets card box to be equal 2' do
        subject.promote
        expect(subject.result).to eq 2
      end
    end

    describe '#execute with incorrect answer' do
      let(:is_promoted) { false }
      it 'leaves card box to be equal 1' do
        subject.promote
        expect(subject.result).to eq 1
      end
    end
  end

  context "Following shows" do
    context "Answer was correct" do
      let(:is_promoted) { true }
      describe '#execute' do
        let(:current_box) { 2 }
        it 'sets card box to be equal 3' do
          subject.promote
          expect(subject.result).to eq 3
        end
      end

      describe '#execute' do
        let(:current_box) { 3 }
        it 'sets card box to be equal 4' do
          subject.promote
          expect(subject.result).to eq 4
        end
      end

      describe '#execute' do
        let(:current_box) { 4 }
        it 'leaves card box to be equal 4' do
          subject.promote
          expect(subject.result).to eq 4
        end
      end
    end

    context "Answer was incorrect" do
      let(:is_promoted) { false }
      describe '#execute with incorrect answer' do
        let(:current_box) { 3 }

        it 'downgrade card box to be equal 2' do
          subject.promote
          expect(subject.result).to eq 1
        end
      end
    end
  end
end

