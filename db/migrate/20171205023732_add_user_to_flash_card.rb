class AddUserToFlashCard < ActiveRecord::Migration[5.1]
  def change
    add_reference :flash_cards, :user, index: true
  end
end
