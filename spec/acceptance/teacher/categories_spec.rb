require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Categories for Teacher" do
  let!(:category) { create :category }
  let!(:tutor) {create :tutor}
  get 'teacher/categories' do
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
      header 'Authorization', "Bearer #{tutor.auth_token}"

      do_request

      expect(status).to eq 200
      expect(response_body).to eq response_json
    end
  end

  get 'teacher/categories/:id' do
    parameter :id, 'ID of category', required: true

    let!(:flash_card) { create :flash_card, category: category }
    let(:response_json) do
      {
        data: {
          name: 'English',
          is_default: false,
          flash_card_ids: [flash_card.id]
        }
      }.to_json
    end

    let(:id) { category.id }

    example "returns requested cards from selected category" do
      header 'Authorization', "Bearer #{tutor.auth_token}"

      do_request

      expect(status).to eq 200
      expect(response_body).to eq response_json
    end
  end

  post 'teacher/categories' do
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
      header 'Authorization', "Bearer #{tutor.auth_token}"

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
        header 'Authorization', "Bearer #{tutor.auth_token}"

        do_request(params)
        expect(status).to eq 422
        expect(response_body).to include response_json
      end
    end
  end
end
