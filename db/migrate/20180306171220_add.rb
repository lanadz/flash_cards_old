class Add < ActiveRecord::Migration[5.1]
  def change
    add_column :flash_card_shows, :box, :integer, default: 0
  end
end
