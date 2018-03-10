class LearningSessionSerializer
  def initialize(learning_session)
    @learning_session = learning_session
  end

  def to_json(options = {})
    {
      data: {
        learning_session_details: {
          id: learning_session[:learning_session_details].id,
          started_at: learning_session[:learning_session_details].started_at.iso8601
        },
        cards: learning_session[:cards].map do |record|
          {
            id: record["id"],
            face: record["face"],
            back: record["back"],
            correct_times: record["correct_times"],
            show_times: record["show_times"],
            box: record["box"]
          }
        end
      }
    }
  end

  alias_method :as_json, :to_json

  private

  attr_reader :learning_session
end
