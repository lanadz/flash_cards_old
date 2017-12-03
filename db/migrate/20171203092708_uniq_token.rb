class UniqToken < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :auth_token, unique: true
  end
end
