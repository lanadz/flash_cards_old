require 'rails_helper'

RSpec.describe AuthorisationSerializer do
  let(:user) { create :user }

  describe '#to_json' do
    subject { described_class.new(user, 'token') }

    let(:response) do
      {
        data: {
          user: {
            name: user.name,
            email: user.email,
            role: user.role
          },
          token: {
            token: 'token',
            expires_at: user.auth_token_expired_at
          }
        }
      }
    end

    it 'returns JSON of user without token' do
      expect(subject.to_json).to eq response
    end
  end
end
