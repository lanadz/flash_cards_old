class AddUniqueConstraintToFlashCardShows < ActiveRecord::Migration[5.1]
  def change
    remove_index :flash_card_shows, [:user_id, :flash_card_id]
    add_index :flash_card_shows, [:user_id, :flash_card_id], unique: true
  end
end
