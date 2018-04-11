class FlashCard
  class ValueObject
    attr_reader :face,
                :back,
                :id,
                :user,
                :creator,
                :category,
                :correct_times,
                :show_times,
                :box

    def initialize(face:,
                   back:,
                   id:,
                   user:,
                   creator:,
                   category:,
                   correct_times:,
                   show_times:,
                   box:)

      @id = id
      @face = face
      @back = back
      @user = user
      @creator = creator
      @category = category
      @correct_times = correct_times
      @show_times = show_times
      @box = box
    end

    def equal?(other)
      id == other.id &&
        face == other.face &&
        back == other.back &&
        user == other.user &&
        creator == other.creator &&
        category == other.category &&
        correct_times == other.correct_times &&
        show_times == other.show_times &&
        box == other.box
    end
  end
end
