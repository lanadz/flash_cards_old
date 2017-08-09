class CategoriesSerializer
  def initialize(categories)
    @categories = categories
  end

  def to_json(options = {})
    {
      data: categories.map do |record|
        {
          name: record.name,
          is_default: record.is_default,
          id: record.id
        }
      end
    }
  end

  alias_method :as_json, :to_json

  private

  attr_reader :categories
end
