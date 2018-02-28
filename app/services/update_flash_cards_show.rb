class UpdateFlashCardsShow
  def initialize(flash_cards_params, user)
    @flash_cards_params = flash_cards_params
    @user = user
  end

  def execute
    flash_cards_params.each do |flash_card_params|
      correct_times = ActiveModel::Type::Boolean.new.cast(flash_card_params[:state]) ? 1 : 0

      flash_card_show = FlashCardShow.find_or_create_by!(
        flash_card_id: flash_card_params[:id],
        user_id: user.id)

      flash_card_show.tap do |flcrd|
        flcrd.show_times = flcrd.show_times.to_i + 1
        flcrd.correct_times = flcrd.correct_times.to_i + correct_times
        flcrd.save!
      end
    end
  end

  private

  attr_reader :flash_cards_params, :user

end
