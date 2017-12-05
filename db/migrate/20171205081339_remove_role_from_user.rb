class RemoveRoleFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_index :users, :role
    remove_column :users, :role, :integer
  end
end
