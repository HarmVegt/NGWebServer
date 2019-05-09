class AddressesController < ApplicationController


  def index
    addresses = Address.all
    render json: {addresses: addresses}, status: :ok
  end

  def create
    customer = Customer.find(params[:customer_id])
    address = customer.address.new(address_params)

    if address.save
      render json: {address: address}, status: :created
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

    render json: {address: address}, status: :ok
  end

  def update

    if params[:customer_id]
      customer = Customer.find(params[:customer_id])
      address = customer.address
    else
      address = Address.find(params[:id])
    end

    if address.update(address_params)
      render json: {address: address}, status: :ok
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
