class RenameLearningSessionToLearningSessionDetail < ActiveRecord::Migration[5.1]
  def change
    rename_table :learning_sessions, :learning_session_details
  end
end
