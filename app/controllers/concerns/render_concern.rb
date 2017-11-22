module RenderConcern
  STATUSES = [
    # Successful statuses
    :ok,
    :created,
    :accepted,

    # Unsuccessful statuses
    :unprocessable_entity,
    :not_acceptable,
    :forbidden,
    :unauthorized,
    :not_found
  ]

  STATUSES.each do |status|
    define_method "render_#{status}" do |data=nil|
      if data.present?
        render json: data, status: status
      else
        render status: status
      end
    end
  end
end
