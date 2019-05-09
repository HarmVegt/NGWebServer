class V1::CustomersController < ApplicationController

  def index
    customers = Customer.all
    render json: {customers: customers}, status: :ok
  end

  def create
    customer = Customer.new(customer_params)

    if customer.save
      render json: {customer: customer}, status: :created
    else
      render json: {errors: customer.errors}, status: :unprocessable_entity
    end

  end

  def show
    customer = Customer.find(params[:id])
    render json: {customer: customer}, status: :ok
  end

  def update
    customer = Customer.find(params[:id])

    if customer.update(customer_params)
      render json: {customer: customer}, status: :ok
    else
      render json: {errors: customer.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    customer = Customer.find(params[:id])
    customer.destroy
    head 204
  end

  private

  def customer_params
    params.require(:customer).permit(:firstname, :lastname, :preposition, :email, :address_id)
  end
end
