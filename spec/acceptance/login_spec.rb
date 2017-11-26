require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Sign in" do
  post '/sessions' do
    parameter :email, "User's email", scope: :registration, required: true
    parameter :password, "User's password", scope: :registration, required: true

    context 'Student' do
      let(:params) do
        {
          signin: {
            email: 'student@mail.com',
            password: 'password'
          }
        }
      end

      let(:response_obj) do
        {
          data: {
            user: {
              name: 'Student',
              email: 'student@mail.com',
              role: 'student'
            },
            token: {
              token: "don't know yet",
              expires_at: "don't know yet"
            }
          }
        }.with_indifferent_access
      end

      example 'signins user' do
        create(:student, password: 'password')

        expect { do_request(params) }.not_to change { User.count }

        response_obj[:data][:token][:expires_at] = User.last.auth_token_expired_at.iso8601(3)
        response_obj[:data][:token][:token] = jwt_encode(User.last.auth_token)

        expect(status).to eq 200
        expect(JSON.parse(response_body)).to eq(response_obj)
      end

      context 'wrong credentials' do
        let(:params) do
          {
            signin: {
              email: 'student@mail.com',
              password: 'wrong password'
            }
          }
        end

        example 'wrong credentials' do
          create(:student, password: 'password')

          expect { do_request(params) }.not_to change { User.count }

          expect(status).to eq 404
          expect(JSON.parse(response_body)).to have_key("errors")
        end
      end
    end
  end
end
