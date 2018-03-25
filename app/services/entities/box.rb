class Box
  attr_reader :level

  def initialize(cards:, level: 0)
    @cards = cards
    @level = level
  end

  def execute
  end
end
