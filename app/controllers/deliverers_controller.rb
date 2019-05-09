class DeliverersController < ApplicationController

  def index
    deliverers = Deliverer.all
    render json: {deliverers: deliverers}, status: :ok
  end

  def create
    deliverer = Deliverer.new(deliverer_params)

    if deliverer.save
      render json: {deliverer: deliverer}, status: :created
    else
      render json: {errors: deliverer.errors}, status: :unprocessable_entity
    end

  end

  def show
    deliverer = Deliverer.find(params[:id])
    render json: {deliverer: deliverer}, status: :ok
  end

  def update
    deliverer = Deliverer.find(params[:id])

    if deliverer.update(deliverer_params)
      render json: {deliverer: deliverer}, status: :ok
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
