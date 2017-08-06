require 'rails_helper'

RSpec.describe CreateLearningSession do
  let(:category) { create :category }
  let!(:flash_card) { create :flash_card, category: category }
  subject { described_class.new(category) }
  it 'fetches flash cards' do
    expect(subject.flash_card_ids).to eq [flash_card.id]
  end
end
