require 'rails_helper'

RSpec.describe FlashCard::ValueObject do
  let(:object) { create :user }
  let(:params) do
    {
      face: 'face',
      back: 'back',
      id: 2,
      user_id: 3,
      creator_id: 4,
      category_id: 1,
      correct_times: 2,
      show_times: 6,
      box: 1
    }
  end

  let(:other_params) do
    {
      face: 'new face',
      back: 'back',
      id: 3,
      user_id: 3,
      creator_id: 4,
      category_id: 1,
      correct_times: 2,
      show_times: 6,
      box: 1
    }
  end
  subject { described_class.new(params) }

  describe '#initialize' do
    it 'creates new object' do
      expect { subject }.not_to raise_error
    end
  end

  describe 'equal?' do
    it 'compares two eq objects' do
      expect(subject).to eq described_class.new(params)
    end

    it 'compares two objects that are not eq' do
      expect(subject).not_to eq described_class.new(other_params)
    end
  end
end

