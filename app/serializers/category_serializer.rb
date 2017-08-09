class CategorySerializer
  def initialize(category)
    @category = category
  end

  def to_json(options = {})
    {
      data: {
        name: category.name,
        is_default: category.is_default,
        id: category.id
      }
    }
  end

  alias_method :as_json, :to_json

  private

  attr_reader :category
end
