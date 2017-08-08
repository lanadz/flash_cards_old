require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe "GET categories" do
    let!(:category) { create :category }
    let(:response_json) do
      [
        {
          id: category.id,
          name: 'English',
          is_default: false
        }
      ].to_json
    end

    it "returns all created categories" do
      get categories_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq response_json
    end
  end

  describe "GET categories/:id" do
    let(:category) { create :category }
    let!(:flash_cards) { create :flash_card, category: category }
    let(:response_json) do
      {
        name: 'English',
        is_default: false,
        flash_cards: [{
          face: '1+1',
          back: '=2'
        }]
      }.to_json
    end

    it "returns requested cards from category" do
      get category_path(category)
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq response_json
    end
  end
end
