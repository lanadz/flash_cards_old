class CreateFlashCardShows < ActiveRecord::Migration[5.1]
  def change
    create_table :flash_card_shows do |t|
      t.bigint :user_id, index: true
      t.bigint :flash_card_id, index: true
      t.integer :show_times
      t.integer :correct_times, index: true
    end
  end
end
