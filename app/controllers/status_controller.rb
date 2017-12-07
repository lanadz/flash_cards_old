class StatusController < ApplicationController
  skip_before_action :require_login
  def show
    render json: {
      status: 'running',
      message: 'Hello from Backend',
    }
  end
end
