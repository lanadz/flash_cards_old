class FlashCardBelongsToCategory < ActiveRecord::Migration[5.1]
  def change
    add_reference :flash_cards, :category, index: true
  end
end
