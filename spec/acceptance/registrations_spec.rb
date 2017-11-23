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

      let(:response_json) do
        {
          data: {
            user: {
              name: 'Student',
              email: 'student@email.com',
              role: 'student',
              token: {
                token: jwt_encode('student_token'),
                expires_in: 3600
              }
            }
          }
        }.to_json
      end

      example 'creates new user' do
        expect{do_request(params)}.to change{User.count}.from(0).to(1)

        expect(status).to eq 201
        expect(response_body).to eq response_json
      end

    end
  end
end
