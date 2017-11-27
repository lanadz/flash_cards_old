require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "FlashCards for Student" do
  let!(:student) { create :student }

  let(:flash_card) { create :flash_card }
  let(:response_json) do
    {data: {face: '1+1', back: '=2'}}.to_json
  end
  let(:id) { flash_card.id }

  get '/flash_cards/:id' do
    parameter :id, 'ID of flash card', required: true

    example 'Show card' do
      header 'Authorization', "Bearer #{jwt_encode(student.auth_token)}"

      do_request
      expect(status).to eq 200
      expect(response_body).to eq response_json
    end
  end
end
