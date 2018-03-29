require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "FlashCards" do
  let(:user) {create :user}
  let(:category) {create :category, user: user}
  let!(:flash_card) { create :flash_card, category: category, creator: user }

  get '/flash_cards' do
    let(:response_json) { {data: [{id: flash_card.id, face: '1+1', back: '=2'}]}.to_json }

    example "returns all created cards" do
      header 'Authorization', "Bearer #{jwt_encode(user.auth_token)}"

      do_request

      expect(status).to eq 200
      expect(response_body).to eq response_json
    end
  end

  get '/flash_cards/:id' do
    parameter :id, 'ID of flash card', required: true
    let(:response_json) do
      {
        data: {
          id: flash_card.id,
          face: flash_card.face,
          back: flash_card.back,
          correct_times: 1,
          show_times: 2,
          box: 1
        }
      }.to_json
    end
    let!(:flash_card_show) { create :flash_card_show, show_times: 2, flash_card: flash_card, user: user }
    let(:id) { flash_card.id }

    example "returns requested card" do
      header 'Authorization', "Bearer #{jwt_encode(user.auth_token)}"

      do_request

      expect(status).to eq 200
      expect(response_body).to eq response_json
    end
  end

  post '/flash_cards' do
    parameter :face, 'Front side of card', scope: :flash_card, required: true
    parameter :back, 'Back side of card', scope: :flash_card, required: true
    parameter :category_id, 'Category ID', scope: :flash_card, required: true

    let(:params) do
      {
        flash_card:
          {
            face: 'Face',
            back: 'Back',
            category_id: category.id
          }
      }
    end

    let(:response_obj) do
      {
        data:
          {
            face: 'Face',
            back: 'Back',
            correct_times: 0,
            show_times: 0,
            box: 0
          }
      }.with_indifferent_access
    end

    example "creates and returns card" do
      header 'Authorization', "Bearer #{jwt_encode(user.auth_token)}"
      expect(FlashCardShow.count).to eq 0
      expect { do_request(params) }.to change { FlashCard.count }.by 1
      expect(FlashCardShow.count).to eq 1
      response_obj[:data][:id] = FlashCard.last.id
      expect(status).to eq 201
      expect(JSON.parse(response_body)).to eq response_obj
    end
  end

  delete '/flash_cards/:id' do
    parameter :id, 'ID of flash card', required: true
    let!(:id) { flash_card.id }

    example "deletes requested card" do
      header 'Authorization', "Bearer #{jwt_encode(user.auth_token)}"

      expect{do_request}.to change{FlashCard.count}.from(1).to(0)
      expect(status).to eq 200
    end
  end
end
