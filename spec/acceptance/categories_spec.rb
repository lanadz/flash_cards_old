require 'rails_helper'
require 'rspec_api_documentation/dsl'


resource "Categories for Student" do
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

  get "/categories" do
    example "Listing Categories" do
      do_request

      expect(status).to eq 200
      expect(response_json).to eq response_json
    end
  end

  get "/categories/:id" do
    let(:category) { create :category }
    let(:id) { category.id }
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

    example "Show Category and returns requested cards from that category" do
      do_request

      expect(status).to eq 200
      expect(response_json).to eq response_json
    end
  end
end
