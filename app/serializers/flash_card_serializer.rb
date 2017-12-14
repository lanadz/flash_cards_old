class FlashCardSerializer
  def initialize(flash_card)
    @face = flash_card.face
    @back = flash_card.back
    @id = flash_card.id
  end

  def to_json(options = {})
    {
      data: {
        id: id,
        face: face,
        back: back
      }
    }
  end

  alias_method :as_json, :to_json

  private

  attr_reader :face, :back, :id
end
