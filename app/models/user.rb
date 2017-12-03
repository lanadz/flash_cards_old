require 'bcrypt'

class User < ApplicationRecord
  include BCrypt

  ROLES = %w(student tutor).freeze

  enum role: ROLES

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: /@/
  validates :encrypted_password, presence: true
  validates :role, presence: true

  def password
    @password ||= Password.new(encrypted_password)
  end

  def password=(new_password)
    if new_password.present?
      @password = Password.create(new_password, cost: 4)
      self.encrypted_password = @password
    end
  end
end
