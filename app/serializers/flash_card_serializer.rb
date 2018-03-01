class FlashCardSerializer
  def initialize(flash_card, flash_card_show = nil)
    @face = flash_card.face
    @back = flash_card.back
    @id = flash_card.id
    @show_times = flash_card_show&.show_times
    @correct_times = flash_card_show&.correct_times
  end

  def to_json(options = {})
    {
      data: {
        id: id,
        face: face,
        back: back,
        correct_times: correct_times,
        show_times: show_times,
      }
    }
  end

  alias_method :as_json, :to_json

  private

  def correct_times
    @correct_times.nil? ? 0 : @correct_times
  end

  def show_times
    @show_times.nil? ? 0 : @show_times
  end

  attr_reader :face, :back, :id
end
