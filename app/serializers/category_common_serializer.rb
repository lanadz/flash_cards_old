class CategoryCommonSerializer

  def initialize(category:, flash_cards:, total_points: 0, last_session_points: 0)
    @name = category.name
    @is_default = category.is_default
    @flash_cards = flash_cards
    @last_session_points = last_session_points
    @total_points = total_points
  end

  def to_json(options = {})
    {
      data: {
        name: name,
        is_default: is_default,
        total_points: total_points,
        last_session_points: last_session_points,
        flash_cards: flash_cards.map do |record|
          {
            id: record.id,
            face: record.face,
            back: record.back
          }
        end
      }
    }
  end

  alias_method :as_json, :to_json

  private

  attr_reader :name, :is_default, :flash_cards, :total_points, :last_session_points
end
