class FlashCardSerializer
  def initialize(flash_card_repo)
    @face = flash_card_repo.flash_card.face
    @back = flash_card_repo.flash_card.back
    @id = flash_card_repo.flash_card.id
    @show_times = flash_card_repo.flash_card_show.show_times
    @correct_times = flash_card_repo.flash_card_show.correct_times
    @box = flash_card_repo.flash_card_show.box
  end

  def to_json(options = {})
    {
      data: {
        id: id,
        face: face,
        back: back,
        correct_times: correct_times,
        show_times: show_times,
        box: box
      }
    }
  end

  alias_method :as_json, :to_json

  private

  attr_reader :face, :back, :id, :correct_times, :show_times, :box
end
