class DeliverersController < ApplicationController

  def index
    deliverers = Deliverer.all
    respond_to do |format|
      format.json {render json: {deliverers: deliverers}, status: :ok}
      format.xml {render xml: deliverers.as_json}
    end
  end

  def create
    deliverer = Deliverer.new(deliverer_params)

    if deliverer.save
      respond_to do |format|
        format.json {render json: {deliverer: deliverer}, status: :created}
        format.xml {render xml: deliverer.as_json}
      end
    else
      render json: {errors: deliverer.errors}, status: :unprocessable_entity
    end

  end

  def show
    deliverer = Deliverer.find(params[:id])
    respond_to do |format|
      format.json {render json: {deliverer: deliverer}, status: :ok}
      format.xml {render xml: deliverer.as_json}
    end
  end

  def update
    deliverer = Deliverer.find(params[:id])

    if deliverer.update(deliverer_params)
      respond_to do |format|
        format.json {render json: {deliverer: deliverer}, status: :ok}
        format.xml {render xml: deliverer.as_json}
      end
    else
      render json: {errors: deliverer.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    deliverer = Deliverer.find(params[:id])
    deliverer.destroy
    head 204
  end

  private

  def deliverer_params
    params.require(:deliverer).permit(:firstname, :lastname, :preposition)
  end

end
