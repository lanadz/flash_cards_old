require 'rails_helper'

RSpec.describe UserSerializer do
  let(:user) { create :student }

  describe '#to_json' do
    context 'do not return token' do
      subject { described_class.new(user) }

      let(:response) do
        {
          data: {
            name: user.name,
            email: user.email,
            role: user.role
          }
        }
      end

      it 'returns JSON of user without token' do
        expect(subject.to_json).to eq response
      end
    end

    context 'return token' do
      subject { described_class.new(user, return_token: true) }

      let(:response) do
        {
          data: {
            name: user.name,
            email: user.email,
            role: user.role
          },
          token: {
            token: jwt_encode(user.auth_token),
            expires_at: user.auth_token_expired_at
          }
        }
      end

      it 'returns JSON of user without token' do
        expect(subject.to_json).to eq response
      end
    end
  end
end
