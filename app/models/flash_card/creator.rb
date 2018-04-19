class FlashCard
  class Creator
    attr_reader :errors, :flash_card

    def initialize(params:, creator:)
      @params = params
      @creator = creator
      @category = params[:category_id]
      @flash_card = nil

      @errors = {}
    end

    def create
      begin
        create_records_in_db_and_build_value_object

        true
      rescue
        set_errors

        false
      end
    end

    private

    def set_errors
      @errors = @flash_card_active_record.errors.present? ? @flash_card_active_record.errors.messages : {flash_card: 'Something went wrong'}
    end

    def create_records_in_db_and_build_value_object
      ensure_records_are_saved_into_db
      build_value_object
    end

    def build_value_object
      @flash_card = ValueObject.new(face: @flash_card_active_record.face,
                                    back: @flash_card_active_record.back,
                                    user_id: @creator.id,
                                    creator_id: @creator.id,
                                    show_times: @flash_card_show.show_times,
                                    correct_times: @flash_card_show.correct_times,
                                    category_id: @category,
                                    box: @flash_card_show.box,
                                    id: @flash_card_active_record.id)
    end

    def ensure_records_are_saved_into_db
      FlashCard.transaction do
        @flash_card_active_record = @creator.flash_cards.new(@params)

        @flash_card_active_record.save!
        @flash_card_show = @flash_card_active_record.flash_card_shows.create!(
          user: @creator,
          show_times: 0,
          correct_times: 0
        )
      end
    end
  end
end
