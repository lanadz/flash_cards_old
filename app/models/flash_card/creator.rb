class FlashCard
  class Creator
    attr_reader :errors, :flash_card, :success


    def initialize
      @params = nil
      @creator = nil
      @category = nil
      @flash_card = ValueObject.new(face: nil,
                                    back: nil,
                                    user_id: nil,
                                    creator_id: nil,
                                    show_times: nil,
                                    correct_times: nil,
                                    category_id: nil,
                                    box: nil,
                                    id: nil)

      @flash_card_show = nil
      @errors = nil
      @success = true
    end

    def create(params:, creator:)
      set_params_for_create(params: params, creator: creator)
      FlashCard.transaction do
        @flash_card_active_record = creator.flash_cards.new(params)

        flash_card_active_record.save!
        @flash_card_show = flash_card_active_record.flash_card_shows.create!(
          user: creator,
          show_times: 0,
          correct_times: 0
        )
      end
      @flash_card = ValueObject.new(face: flash_card_active_record.face,
                                    back: flash_card_active_record.back,
                                    user_id: creator.id,
                                    creator_id: creator.id,
                                    show_times: flash_card_show.show_times,
                                    correct_times: flash_card_show.correct_times,
                                    category_id: category,
                                    box: flash_card_show.box,
                                    id: flash_card_active_record.id)
    rescue
      @success = false
      @errors = flash_card_active_record.errors.present? ? flash_card_active_record.errors.messages : {flash_card: 'Something went wrong'}
    end

    private

    attr_reader :params,
                :creator,
                :category,
                :flash_card_active_record,
                :flash_card_show

    def set_params_for_create(params:, creator:)
      @params = params
      @creator = creator
      @category = params[:category_id]
    end

  end
end
