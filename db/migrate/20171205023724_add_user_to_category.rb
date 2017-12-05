class AddUserToCategory < ActiveRecord::Migration[5.1]
  def change
    add_reference :categories, :user, index: true
  end
end
