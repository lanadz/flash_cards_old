class CategoryWithCardsSerializer < ActiveModel::Serializer
  attributes :name, :is_default
  has_many :flash_cards, serializer: FlashCardSerializer
end
