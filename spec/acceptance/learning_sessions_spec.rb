require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "LearningSessions" do
  post '/learning_sessions' do
    parameter :category_id, "Category ID", required: true
    parameter :include, "Array of resources to add, i.e. [flash_cards]"

    let!(:user) { create :user }

    let(:user) { create :user }
    let(:category) { create :category, user: user }
    let!(:flash_cards) { create :flash_card, category: category, user: user }
    let(:response_json) do
      {
        data: {
          learning_session_details: {
            id: nil,
            started_at: nil
          },
          cards: [
            {
              id: flash_cards.id,
              face: flash_cards.face,
              back: flash_cards.back,
            }
          ]
        }
      }.with_indifferent_access

    end
    let(:params) { {category_id: category.id} }

    example 'creates new learning session and returns flash cards' do
      header 'Authorization', "Bearer #{jwt_encode(user.auth_token)}"

      expect { do_request(params) }.to change { LearningSessionDetail.count }.by(1)
      learning_session_detail = LearningSessionDetail.last
      response_json[:data][:learning_session_details][:id] = learning_session_detail.id
      response_json[:data][:learning_session_details][:started_at] = learning_session_detail.started_at.iso8601
      expect(status).to eq 200
      expect(JSON.parse(response_body)).to eq response_json
    end
  end
end
