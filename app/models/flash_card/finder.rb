class FlashCard
  class Finder
    def initialize(user:)
      @user = user
    end

    def find_by(category_id:)
      flash_cards = FlashCard.where(category_id: category_id)
                      .joins("INNER JOIN flash_card_shows
                              ON flash_card_shows.flash_card_id = flash_cards.id
                              AND flash_card_shows.user_id = #{@user.id}")
                      .select('flash_cards.id AS id',
                              'flash_cards.face AS face',
                              'flash_cards.back AS back',
                              'flash_cards.category_id AS category_id',
                              'flash_cards.creator_id AS creator_id',
                              'flash_card_shows.user_id AS user_id',
                              'flash_card_shows.show_times AS show_times',
                              'flash_card_shows.correct_times AS correct_times',
                              'flash_card_shows.box AS box'
                      )
      flash_cards.map do |flash_card|
        ValueObject.new(face: flash_card.face,
                        back: flash_card.back,
                        user_id: flash_card.user_id,
                        creator_id: flash_card.creator_id,
                        show_times: flash_card.show_times,
                        correct_times: flash_card.correct_times,
                        category_id: flash_card.category_id,
                        box: flash_card.box,
                        id: flash_card.id)
      end
    end

    private

  end
end
