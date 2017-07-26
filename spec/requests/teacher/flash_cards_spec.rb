require 'rails_helper'

RSpec.describe "FlashCards", type: :request do
  describe "GET teacher/flash_cards" do
    let!(:flash_card) { create :flash_card }
    let(:response_json) { [{face: '1+1', back: '=2'}].to_json }

    it "returns all created cards" do
      get teacher_flash_cards_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq response_json

    end
  end

  describe "GET teacher/flash_cards/:id" do
    let(:flash_card) { create :flash_card }
    let(:response_json) do
      {face: '1+1', back: '=2'}.to_json
    end

    it "returns requested card" do
      get teacher_flash_card_path(flash_card)
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq response_json
    end
  end

  describe "POST teacher/flash_cards" do
    let(:params) do
      {
        flash_card:
          {
            face: 'Face',
            back: 'Back'
          }
      }
    end

    let(:response_json) do
      {face: 'Face', back: 'Back'}.to_json
    end

    it "creates and returns card" do
      post teacher_flash_cards_path(params)
      expect(response).to have_http_status(:created)
      expect(response.body).to eq response_json
    end
  end

  describe "DELETE teacher/flash_cards/:id" do
    let(:flash_card) { create :flash_card }

    it "deletes requested card" do
      delete teacher_flash_card_path(flash_card)
      expect(response).to have_http_status(:ok)
    end
  end
end
