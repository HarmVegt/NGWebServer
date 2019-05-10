class AddressesController < ApplicationController

  def index
    addresses = Address.all
    respond_to do |format|
      format.json {render json: {addresses: addresses}, status: :ok}
      format.xml {render xml: addresses.as_json}
    end
  end

  def create
    customer = Customer.find(params[:customer_id])
    address = customer.address.new(address_params)

    if address.save
      respond_to do |format|
        format.json {render json: {address: address}, status: :created}
        format.xml {render xml: address.as_json}
      end
    else
      render json: {errors: address.errors}, status: :unprocessable_entity
    end

  end

  def show

    if params[:customer_id]
      customer = Customer.find(params[:customer_id])
      address = customer.address
    else
      address = Address.find(params[:id])
    end

    respond_to do |format|
      format.json {render json: {address: address}, status: :ok}
      format.xml {render xml: address.as_json}
    end
  end

  def update

    if params[:customer_id]
      customer = Customer.find(params[:customer_id])
      address = customer.address
    else
      address = Address.find(params[:id])
    end

    if address.update(address_params)
      respond_to do |format|
        format.json {render json: {address: address}, status: :ok}
        format.xml {render xml: address.as_json}
      end
    else
      render json: {errors: address.errors}, status: :unprocessable_entity
    end
  end

  def destroy

    if params[:customer_id]
      customer = Customer.find(params[:customer_id])
      address = customer.address
    else
      address = Address.find(params[:id])
    end

    address.destroy
    head 204
  end

  private

  def address_params
    params.require(:address).permit(:zipcode, :housenumber, :city, :annex, :x, :y)
  end
end
