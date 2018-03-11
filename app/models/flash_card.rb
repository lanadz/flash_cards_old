class FlashCard < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_one :flash_card_show
end
