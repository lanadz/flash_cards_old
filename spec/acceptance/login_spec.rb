require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Sign in" do
  post '/sessions' do
    parameter :email, "User's email", scope: :registration, required: true
    parameter :password, "User's password", scope: :registration, required: true

    let!(:user) { create(:user, password: 'password') }

    let(:params) do
      {
        signin: {
          email: 'user@mail.com',
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
      expect { do_request(params) }.not_to change { User.count }
      user.reload
      response_obj[:data][:token][:expires_at] = user.auth_token_expired_at.iso8601(3)
      response_obj[:data][:token][:token] = jwt_encode(user.auth_token)

      expect(status).to eq 200
      expect(JSON.parse(response_body)).to eq(response_obj)
    end

    context 'wrong credentials' do
      let(:params) do
        {
          signin: {
            email: 'user@mail.com',
            password: 'wrong password'
          }
        }
      end

      example 'wrong credentials' do
        expect { do_request(params) }.not_to change { User.count }
        user.reload
        expect(status).to eq 404
        expect(JSON.parse(response_body)).to have_key("errors")
      end
    end
  end
end
