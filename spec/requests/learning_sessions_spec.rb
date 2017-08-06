require 'rails_helper'

RSpec.describe "LearningSessions", type: :request do
  describe "POST /learning_sessions" do
    let!(:flash_cards) { create :flash_card, category: category }
    let(:category) { create :category }
    let(:response_json) do
      {flash_card_ids: [flash_cards.id]}.to_json
    end

    it "creates new learning session and returns flash_card_ids" do
      post learning_sessions_path({category_id: category.id})
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq response_json
    end
  end
end
