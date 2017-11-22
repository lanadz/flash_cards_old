class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.string :encrypted_password, null: false
      t.integer :role, null: false
      t.string :auth_token
      t.datetime :auth_token_expired_at
      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :role
    add_index :users, [:auth_token, :auth_token_expired_at]
  end
end
