require 'rails_helper'

RSpec.describe FlashCard::Creator do
  let(:user) { create :user }
  let(:category) { create :category, user: user }
  let(:params) { {face: 'Face', back: 'Back', category_id: category.id} }
  subject { described_class.new }
  describe '#create' do
    it 'creates card and related card show for current user' do
      expect { subject.create(params: params, creator: user) }.to change { FlashCard.count }.from(0).to(1)
      expect(FlashCardShow.count).to eq 1
      obj = FlashCard::ValueObject.new(face: 'Face',
                            back: 'Back',
                            user_id: user.id,
                            creator_id: user.id,
                            show_times: 0,
                            correct_times: 0,
                            category_id: category.id,
                            box: 0,
                            id: FlashCard.last.id)
      expect(subject.flash_card).to be_equal obj
    end
  end

  describe "#errors" do
    context 'doesnt have errors' do
      it 'doesnt fill the errors array' do
        subject.create(params: params, creator: user)
        expect(subject.errors).to eq nil
      end
    end

    context 'params are missing' do
      let(:params) { {face: 'Face'} }
      it 'fills the errors array' do
        subject.create(params: params, creator: user)
        expect(subject.errors).to be_present
      end
    end
  end
end

