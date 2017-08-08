require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Categories for Teacher" do
  let!(:category) { create :category }

  get 'teacher/categories' do
    let(:response_json) do
      [
        {
          id: category.id,
          name: 'English',
          is_default: false
        }
      ].to_json
    end

    example_request "Get all categories" do
      expect(status).to eq 200
      expect(response_body).to eq response_json
    end
  end

  get 'teacher/categories/:id' do
    parameter :id, 'ID of category', required: true

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
    let(:id) { category.id }

    example_request "returns requested cards from selected category" do
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
      do_request(params)
      expect(status).to eq 201
      expect(JSON.parse(response_body)).to include response_obj
    end
  end
end
