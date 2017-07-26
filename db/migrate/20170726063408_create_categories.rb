class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.boolean :is_default, dafault: false, index: true
      t.timestamps
    end
  end
end
