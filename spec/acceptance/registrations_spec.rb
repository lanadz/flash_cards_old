require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Registrations" do
  post '/registrations' do
    parameter :name, "User's name", scope: :registration, required: true
    parameter :email, "User's email", scope: :registration, required: true
    parameter :role, "User's role [tutor | student]", scope: :registration, required: true
    parameter :password, "User's password", scope: :registration, required: true

    context 'Student' do
      let(:params) do
        {
          registration: {
            name: 'Student',
            email: 'student@email.com',
            role: 'student',
            password: 'password'
          }
        }
      end

      let(:response_obj) do
        {
          data: {
            user: {
              name: 'Student',
              email: 'student@email.com',
              role: 'student'
            },
            token: {
              token: "don't know yet",
              expires_at: "don't know yet"
              }
            }
        }.with_indifferent_access
      end

      example 'creates new user' do
        expect{do_request(params)}.to change{User.count}.from(0).to(1)

        response_obj[:data][:token][:expires_at] = User.last.auth_token_expired_at.iso8601(3)
        response_obj[:data][:token][:token] = jwt_encode(User.last.auth_token)

        expect(status).to eq 201
        expect(JSON.parse(response_body)).to eq(response_obj)
      end

    end
  end
end
