class FlashCardSerializer
  def initialize(flash_card)
    @face = flash_card.face
    @back = flash_card.back
  end

  def to_json(options = {})
    {
      data: {
        face: face,
        back: back
      }
    }
  end

  alias_method :as_json, :to_json

  private

  attr_reader :face, :back
end
