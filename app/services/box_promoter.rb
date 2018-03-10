class BoxPromoter
  BOX_NUMBER = ENV.fetch('BOX_NUMBER', 4).to_i.freeze

  attr_reader :result

  def initialize(current_box:, is_promoted:)
    @current_box = current_box
    @is_promoted = is_promoted
    @result = @current_box
  end

  def promote
    if is_promoted
      should_be_promoted
    else
      should_not_be_promoted
    end
  end

  private

  def should_be_promoted
    if current_box < BOX_NUMBER
      @result += 1
    end
  end

  def should_not_be_promoted
    @result = 1
  end

  attr_reader :current_box, :is_promoted

end
