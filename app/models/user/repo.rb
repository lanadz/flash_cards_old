class User
  class Repo
    attr_reader :errors, :user

    def initialize(params:)
      params[:email] = params[:email].downcase
      @params = params
      @errors = Array.new
      @user = nil
    end

    def execute
      User.transaction do
        @user = User.new(params)
        @category = @user.categories.new(name: "General", is_default: true)

        if !user.save || !category.save
          @errors << user.errors if user.errors.present?
          @errors << category.errors if category.errors.present?
          raise ActiveRecord::Rollback
        end
      end

      self
    end

    private

    attr_reader :params,
                :category

  end
end
