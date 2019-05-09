class V1::RetoursController < ApplicationController

  def index
    if params[:customer_id]
      customer = Customer.find(params[:customer_id])
      retours = customer.retours
    else
      retours = Retour.all
    end

    render json: {retours: retours}, status: :ok
  end

  def create
    customer = Customer.find(params[:customer_id])
    retour = customer.retours.new(retour_params0)

    if retour.save
      render json: {retour: retour}, status: :created
    else
      render json: {errors: retour.errors}, status: :unprocessable_entity
    end

  end

  def show
    if params[:customer_id]
      customer = Customer.find(params[:customer_id])
      retour = customer.retour.find(params[:id])
    else
      retour = Retour.find(params[:id])
    end

    render json: {retour: retour}, status: :ok
  end

  def update
    if params[:customer_id]
      customer = Customer.find(params[:customer_id])
      retour = customer.retours.find(params[:id])
    else
      retour = Retour.find(params[:id])
    end

    if retour.update(retour_params)
      render json: {retour: retour}, status: :ok
    else
      render json: {errors: retour.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    if params[:customer_id]
      customer = Customer.find(params[:customer_id])
      retour = customer.retours.find(params[:id])
    else
      retour = Retour.find(params[:id])
    end

    retour.destroy
    head 204
  end

  private

  def retour_params
    params.require(:retour).permit(:customer_id, :status)
  end

end
