class CreateFlashCards < ActiveRecord::Migration[5.1]
  def change
    create_table :flash_cards do |t|
      t.text :face
      t.text :back
      t.timestamps
    end
  end
end
