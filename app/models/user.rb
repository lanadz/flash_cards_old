class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: false
  validates :role, presence: false
end
