require 'bcrypt'

class User < ApplicationRecord
  include BCrypt

  ROLES = %w(student tutor).freeze

  enum role: ROLES

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: false
  validates :role, presence: false
  validates :auth_token, uniqueness: true

  def password
    @password ||= Password.new(encrypted_password)
  end

  def password=(new_password)
    @password = Password.create(new_password, cost: 4)
    self.encrypted_password = @password
  end
end
