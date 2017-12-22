class Category < ApplicationRecord
  has_many :flash_cards
  has_many :learning_session_details
  validates :name, presence: true
  belongs_to :user
end
