class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  before_action :isApplication

  def isApplication
    if params[:authKey] != "bhLBIuYQr0jZ8COVg9eR"
      respond_to do |format|
        format.json {render json: "Unauthorized!", status: :forbidden}
        format.xml {render xml: "Unauthorized!", status: :forbidden}
      end
    end
  end
end
