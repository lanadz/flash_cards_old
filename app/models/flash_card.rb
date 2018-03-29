class FlashCard < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  has_many :flash_card_shows

  validates :back, :face, exclusion: { in: [nil]}
end
