class LearningSessionDetailsForCategory
  attr_reader :total_points, :last_session_points

  def initialize(learning_sessions)
    @learning_sessions = learning_sessions
    @total_points = 0
    @last_session_points = 0
  end

  def execute
    @total_points = learning_sessions.reduce(0) do |total_points, learning_session|
      total_points += learning_session.correct_answers
      total_points
    end

    @last_session_points = learning_sessions.last&.correct_answers || 0
    self
  end

  private

  attr_reader :learning_sessions

end
