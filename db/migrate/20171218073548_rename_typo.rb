class RenameTypo < ActiveRecord::Migration[5.1]
  def change
    rename_column :learning_session_details, :categpry_id, :category_id
  end
end
