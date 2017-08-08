require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "FlashCards for Student" do
  let(:flash_card) { create :flash_card }
  let(:response_json) do
    {face: '1+1', back: '=2'}.to_json
  end
  let(:id) { flash_card.id }

  get '/flash_cards/:id' do
    parameter :id, 'ID of flash card', required: true

    example_request 'Show card' do
      expect(status).to eq 200
      expect(response_body).to eq response_json
    end
  end
end
