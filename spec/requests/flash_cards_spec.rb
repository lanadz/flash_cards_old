require 'rails_helper'

RSpec.describe "FlashCards", type: :request do
  describe "GET /flash_cards/:id" do
    let(:flash_card) { create :flash_card }
    let(:response_json) { flash_card.to_json }

    it "returns requested flash card" do
      get flash_card_path(flash_card)
      expect(response).to have_http_status(200)
      expect(response.body).to eq response_json
    end
  end
end
