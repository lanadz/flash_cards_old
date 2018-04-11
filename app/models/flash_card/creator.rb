class FlashCard
  class Creator
    attr_reader :errors, :flash_card, :success, :flash_card_show


    def initialize
      @params = nil
      @creator = nil
      @category = nil
      @flash_card = nil
      @flash_card_show = nil
      @errors = nil
      @success = true
    end

    def create(params:, creator:)
      set_params_for_create(params: params, creator: creator)
      FlashCard.transaction do
        @flash_card = creator.flash_cards.new(params)

        flash_card.save!
        @flash_card_show = flash_card.flash_card_shows.create!(
          user: creator,
          show_times: 0,
          correct_times: 0
        )
      end
      self
    rescue
      @success = false
      @errors = flash_card.errors.present? ? flash_card.errors.messages : { flash_card: 'Something went wrong'}
        self
    end

    private

    attr_reader :params,
                :creator,
                :category

    def set_params_for_create(params:, creator:)
      @params = params
      @creator = creator
      @category = params[:category_id]
    end

  end
end
