class Category < ApplicationRecord
  has_many :flash_cards
  validates :name, presence: true
end
