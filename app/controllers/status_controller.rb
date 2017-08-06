class StatusController < ApplicationController
  def show
    render json: {
      status: 'running',
      message: 'Hello from Backend',
    }
  end
end
