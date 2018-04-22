class FlashCard
  class ValueObject
    include Comparable
    attr_reader :face,
                :back,
                :id,
                :user_id,
                :creator_id,
                :category_id,
                :correct_times,
                :show_times,
                :box

    def initialize(face: nil,
                   back: nil,
                   id: nil,
                   user_id: nil,
                   creator_id: nil,
                   category_id: nil,
                   correct_times: nil,
                   show_times: nil,
                   box: nil)

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

    def ==(other)
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
