require 'rails_helper'

RSpec.describe BoxPromoter do
  subject { described_class.new(current_box: current_box, is_promoted: is_promoted) }

  describe '#execute' do
    let(:current_box) { 0 }
    let(:is_promoted) { true }

    it 'sets card box to be equal 1 on first show' do
      subject.promote
      expect(subject.result).to eq 1
    end
  end
end

