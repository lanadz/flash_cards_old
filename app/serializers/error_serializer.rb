class ErrorSerializer
  def initialize(errors)
    @errors = errors
  end

  def to_json(options = {})
    {
      errors: errors
    }.to_json
  end

  alias_method :as_json, :to_json

  private

  attr_reader :errors
end
