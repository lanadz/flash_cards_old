require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Registrations" do
  post '/registrations' do
    parameter :name, "User's name", scope: :registration, required: true
    parameter :email, "User's email", scope: :registration, required: true
    parameter :password, "User's password", scope: :registration, required: true

    context 'Student' do
      let(:params) do
        {
          registration: {
            name: 'User',
            email: 'User@mail.com',
            password: 'password'
          }
        }
      end

      let(:response_obj) do
        {
          data: {
            user: {
              name: 'User',
              email: 'user@mail.com',
            },
            token: {
              token: "don't know yet",
              expires_at: "don't know yet"
              }
            }
        }.with_indifferent_access
      end

      example 'creates new user' do
        expect(Category.count).to eq 0
        expect{do_request(params)}.to change{User.count}.from(0).to(1)
        expect(Category.count).to eq 1

        response_obj[:data][:token][:expires_at] = User.last.auth_token_expired_at.iso8601(3)
        response_obj[:data][:token][:token] = jwt_encode(User.last.auth_token)

        expect(status).to eq 201
        expect(JSON.parse(response_body)).to eq(response_obj)
      end


      example 'user already registred' do
        create(:user, email: 'user@mail.com')
        expect{do_request(params)}.not_to change{User.count}

        expect(status).to eq 422
        expect(JSON.parse(response_body)).to have_key("errors")
      end
    end
  end
end
