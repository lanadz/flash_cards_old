require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Categories" do
  let(:user) { create :user }
  let!(:category) { create :category, user: user }
  get '/categories' do
    let(:response_json) do
      {
        data: [
          {
            name: 'English',
            is_default: false,
            id: category.id
          }
        ]
      }.to_json
    end

    example "Get all categories" do
      header 'Authorization', "Bearer #{jwt_encode(user.auth_token)}"

      do_request

      expect(status).to eq 200
      expect(response_body).to eq response_json
    end
  end

  get '/categories/:id' do
    parameter :id, 'ID of category', required: true

    let!(:flash_card) { create :flash_card, creator: user, category: category }
    let!(:learning_sessions) { create :learning_session_detail, category: category, user: user, correct_answers: 5, started_at: Time.current }
    let!(:last_learning_session) { create :learning_session_detail, category: category, user: user, correct_answers: 10, started_at: Time.current }
    let(:response_json) do
      {
        data: {
          name: 'English',
          is_default: false,
          total_points: 15,
          last_session_points: 10,
          flash_cards: [
            {
              id: flash_card.id,
              face: flash_card.face,
              back: flash_card.back,
            }
          ]
        }
      }.to_json
    end

    let(:id) { category.id }

    example "returns category info and requested cards from selected category" do
      header 'Authorization', "Bearer #{jwt_encode(user.auth_token)}"

      do_request

      expect(status).to eq 200
      expect(response_body).to eq response_json
    end
  end

  post 'categories' do
    parameter :name, 'Name of category', scope: :category, required: true

    let(:params) do
      {
        category:
          {
            name: 'Math'
          }
      }
    end

    let(:response_obj) do
      {
        'name' => 'Math',
        'is_default' => false
      }
    end

    example "creates and returns category" do
      header 'Authorization', "Bearer #{jwt_encode(user.auth_token)}"

      do_request(params)
      expect(status).to eq 201
      expect(json_body).to include response_obj
    end

    context 'fail validations' do
      let(:params) do
        {
          category:
            {
              name: ''
            }
        }
      end

      let(:response_json) do
        {
          errors: {
            name: ["can't be blank"]
          }
        }.to_json
      end

      example "doesnt create category without name provided" do
        header 'Authorization', "Bearer #{jwt_encode(user.auth_token)}"

        do_request(params)
        expect(status).to eq 422
        expect(response_body).to include response_json
      end
    end
  end
end
