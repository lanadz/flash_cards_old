require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "LearningSessions" do
  let!(:user) { create :user }

  let(:user) { create :user }
  let(:category) { create :category, user: user }

  post '/learning_sessions' do
    parameter :category_id, "Category ID", required: true
    parameter :include, "Array of resources to add, i.e. [flash_cards]"

    let(:flash_card) { create :flash_card, category: category, user: user }
    let!(:flash_card_show) { create :flash_card_show, flash_card: flash_card, user: user, show_times: 2 }

    let(:response_json) do
      {
        data: {
          learning_session_details: {
            id: nil,
            started_at: nil
          },
          cards: [
            {
              id: flash_card.id,
              face: flash_card.face,
              back: flash_card.back,
              correct_times: 1,
              show_times: 2
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

  put 'learning_sessions/:id' do
    parameter :correct_answers, "Number of correct answers", scope: :learning_session_detail, required: true
    parameter :wrong_answers, "Number of wrong answers", scope: :learning_session_detail, required: true
    parameter :flash_cards, "Status for each card", scope: :learning_session_detail, required: true

    let!(:learning_session_detail) { create :learning_session_detail, user: user, category: category }
    let(:id) { learning_session_detail.id }
    let(:flash_cards) { create_list :flash_card, 2, category: category, user: user }
    let!(:params) do
      {
        learning_session_detail: {
          correct_answers: 4,
          wrong_answers: 2,
          flash_cards: [
            {id: flash_cards.first.id, state: true},
            {id: flash_cards.last.id, state: false}
          ]
        }
      }
    end
    let(:response_json) { {data: {message: 'Updated'}}.to_json }

    example 'updates learning session detail' do
      header 'Authorization', "Bearer #{jwt_encode(user.auth_token)}"

      expect(FlashCardShow.count).to eq 0
      expect { do_request(params) }.to change { LearningSessionDetail.count }.by(0)
      expect(FlashCardShow.count).to eq 2
      learning_session_detail.reload

      expect(learning_session_detail.correct_answers).to eq 4
      expect(learning_session_detail.wrong_answers).to eq 2
      expect(learning_session_detail.finished_at).not_to be nil

      expect(FlashCardShow.find_by(user: user, flash_card: flash_cards.first).show_times).to eq 1
      expect(FlashCardShow.find_by(user: user, flash_card: flash_cards.first).correct_times).to eq 1

      expect(FlashCardShow.find_by(user: user, flash_card: flash_cards.last).show_times).to eq 1
      expect(FlashCardShow.find_by(user: user, flash_card: flash_cards.last).correct_times).to eq 0

      expect(status).to eq 200
      expect(response_body).to eq response_json
    end
  end
end
