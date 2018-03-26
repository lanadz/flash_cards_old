class RenameUserIdToCreatorId < ActiveRecord::Migration[5.1]
  def change
    rename_column :flash_cards, :user_id, :creator_id
  end
end
