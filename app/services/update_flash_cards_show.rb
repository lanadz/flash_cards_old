class UpdateFlashCardsShow
  def initialize(flash_cards_params, user)
    @flash_cards_params = flash_cards_params
    @user = user
  end

  def execute
    flash_cards_params.each do |flash_card_params|
      is_correct = ActiveModel::Type::Boolean.new.cast(flash_card_params[:state])
      correct_times = is_correct ? 1 : 0

      flash_card_show = FlashCardShow.find_or_create_by!(
        flash_card_id: flash_card_params[:id],
        user_id: user.id)

      flash_card_show.tap do |flcrd|
        flcrd.show_times = flcrd.show_times.to_i + 1
        flcrd.correct_times = flcrd.correct_times.to_i + correct_times
        promote_box(flash_card: flcrd, promote: is_correct)
        flcrd.save!
      end
    end
  end

  private

  def promote_box(flash_card:, promote:)
    box_number = ENV.fetch('BOX_NUMBER', 4).to_i
    flash_card.box = 1 # initial show
    if promote
      if flash_card.box < box_number
        flash_card.box += 1
      end
    else
      if flash_card.box > 1
        flash_card.box -= 1
      end
    end
  end

  attr_reader :flash_cards_params, :user

end
