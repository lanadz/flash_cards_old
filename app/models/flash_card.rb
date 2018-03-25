class FlashCard < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :flash_card_shows # should be has_many, since eventually one flash card can be learnt by many people. and each person should have own flash card show
end
