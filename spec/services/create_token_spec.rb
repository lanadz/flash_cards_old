require 'rails_helper'

RSpec.describe CreateToken do
  let(:student) { create :student, auth_token: nil, auth_token_expired_at: nil }

  subject { described_class.new(student) }

  it "generates token and expiry_date and updates user's fields" do
    subject.execute
    student.reload
    expect(student.auth_token).to be_present
    expect(student.auth_token_expired_at).to be_present
  end
end
