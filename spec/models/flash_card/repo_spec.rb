require 'rails_helper'

RSpec.describe FlashCard::Repo do
  let(:user) { create :user }
  let(:category) { create :category, user: user }
  let(:params) { {face: 'Face', back: 'Back', category_id: category.id} }
  subject { described_class.new(params: params, creator: user) }
  it 'creates card and related card show for current user' do
    expect { subject.execute }.to change { FlashCard.count }.from(0).to(1)
    expect(FlashCardShow.count).to eq 1
  end

  describe "#errors" do
    context 'doesnt have errors' do
      it 'doesnt fill the errors array' do
        subject.execute
        expect(subject.errors).to eq []
      end
    end
  end
end

