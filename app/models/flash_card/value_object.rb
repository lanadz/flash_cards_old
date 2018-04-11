class FlashCard
  class ValueObject
    attr_reader :face,
                :back,
                :id,
                :user_id,
                :creator_id,
                :category_id,
                :correct_times,
                :show_times,
                :box

    def initialize(face:,
                   back:,
                   id:,
                   user_id:,
                   creator_id:,
                   category_id:,
                   correct_times:,
                   show_times:,
                   box:)

      @id = id
      @face = face
      @back = back
      @user_id = user_id
      @creator_id = creator_id
      @category_id = category_id
      @correct_times = correct_times
      @show_times = show_times
      @box = box
    end

    def equal?(other)
      id == other.id &&
        face == other.face &&
        back == other.back &&
        user_id == other.user_id &&
        creator_id == other.creator_id &&
        category_id == other.category_id &&
        correct_times == other.correct_times &&
        show_times == other.show_times &&
        box == other.box
    end
  end
end
