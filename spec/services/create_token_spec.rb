require 'rails_helper'

RSpec.describe CreateToken do
  let(:user) { create :user, auth_token: nil, auth_token_expired_at: nil }

  subject { described_class.new(user) }

  it "generates token and expiry_date and updates user's fields" do
    subject.execute
    user.reload
    expect(user.auth_token).to be_present
    expect(user.auth_token_expired_at).to be_present
  end
end
