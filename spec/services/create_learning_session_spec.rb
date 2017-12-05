require 'rails_helper'

RSpec.describe CreateLearningSession do
  let(:user) { create :user }
  let(:category) { create :category, user: user }
  let!(:flash_card) { create :flash_card, user: user, category: category }
  subject { described_class.new(category) }
  it 'fetches flash cards' do
    expect(subject.flash_card_ids).to eq [flash_card.id]
  end
end
