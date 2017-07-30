class AddDefaultsToCategories < ActiveRecord::Migration[5.1]
  def change
    change_column :categories, :is_default, :boolean, default: false, index: true
  end
end
