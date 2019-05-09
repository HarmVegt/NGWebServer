class ApplicationController < ActionController::API

  before_action :isApplication

  def isApplication
    if params[:authKey] != "bhLBIuYQr0jZ8COVg9eR"
      render json: "Unauthorized!", status: :forbidden
    end
  end
end
