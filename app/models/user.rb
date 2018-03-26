require 'bcrypt'

class User < ApplicationRecord
  include BCrypt

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: /@/
  validates :encrypted_password, presence: true

  has_many :categories
  has_many :flash_cards, foreign_key: :creator_id
  has_many :learning_session_details
  has_many :flash_card_shows

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
