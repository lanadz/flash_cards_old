require 'rails_helper'

RSpec.describe CardSelector do
  let(:cards_per_session) { ENV.fetch('CARDS_PER_SESSION', 10) }
  let(:box_1) { double("box1") }
  let(:box_2) { double("box2") }
  let(:box_3) { double("box3") }
  let(:box_4) { double("box4") }
  let(:set_of_boxes) do
    [
      box_1,
      box_2,
      box_3,
      box_4,
    ]
  end

  subject { described_class.new(set_of_boxes) }

  describe '#initialize' do
    it "creates new instance" do
      subject
    end
  end

  describe '#execute' do
    context 'result' do
      it 'returns array of cards' do
        expect(subject.execute).to be_a(Array)
      end
    end
  end
end
