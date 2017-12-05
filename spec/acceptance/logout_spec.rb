require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Sign out" do
  let(:user) { create(:user, password: 'password') }

  delete '/sessions/signout' do

    let(:response_obj) do
      {
        data: {
          message: 'Bye'
        }
      }.with_indifferent_access
    end

    example 'signs out user' do

      header 'Authorization', "Bearer #{jwt_encode(user.auth_token)}"
      do_request
      user.reload
      expect(user.auth_token).to be_nil
      expect(user.auth_token_expired_at).to be_nil
      expect(status).to eq 200
      expect(JSON.parse(response_body)).to eq(response_obj)
    end

    context 'wrong credentials' do
      example 'wrong credentials' do
        create(:user, password: 'password')

        do_request

        expect(status).to eq 401
        expect(JSON.parse(response_body)).to have_key("errors")
      end
    end
  end
end
