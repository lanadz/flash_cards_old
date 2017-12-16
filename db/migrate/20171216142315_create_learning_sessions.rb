class CreateLearningSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :learning_sessions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :categpry, index: true
      t.integer :correct_answers
      t.integer :wrong_answers
      t.integer :cards_amount

      t.datetime :started_at, index: true
      t.datetime :finished_at
    end
  end
end
