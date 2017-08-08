require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "LearningSessions" do
  post '/learning_sessions' do
    parameter :category_id, "Category ID", required: true

    let!(:flash_cards) { create :flash_card, category: category }
    let(:category) { create :category }
    let(:response_json) do
      {flash_card_ids: [flash_cards.id]}.to_json
    end
    let(:params) { {category_id: category.id} }

    example 'creates new learning session and returns flash_card_ids' do
      do_request(params)
      expect(status).to eq 200
      expect(response_body).to eq response_json
    end
  end
end
