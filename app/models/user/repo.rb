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
      begin
        User.transaction do
          @user = User.new(params)

          if user.save
            @category = user.categories.new(name: "General", is_default: true)
            raise ActiveRecord::Rollback unless @category.save
          else
            raise ActiveRecord::Rollback
          end
        end
      rescue ActiveRecord::Rollback
        @errors << user.errors if user.errors.present?
        @errors << category.errors if category.errors.present?
      end

      self
    end

    private

    attr_reader :params,
                :category

  end
end
