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
        flcrd.box = promoted_box(flcrd.box, is_correct)
        flcrd.save!
      end
    end
  end

  private

  def promoted_box(flash_card_box, is_promoted)
    box_promoter = BoxPromoter.new(current_box: flash_card_box, is_promoted: is_promoted)
    box_promoter.promote
    box_promoter.result
  end

  attr_reader :flash_cards_params, :user

end
