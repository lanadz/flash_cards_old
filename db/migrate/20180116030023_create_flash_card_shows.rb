class CreateFlashCardShows < ActiveRecord::Migration[5.1]
  def change
    create_table :flash_card_shows do |t|
      t.bigint :user_id
      t.bigint :flash_card_id
      t.integer :show_times
      t.integer :correct_times
    end

    add_index :flash_card_shows, [:user_id, :flash_card_id]
  end
end
