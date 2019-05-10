class CustomersController < ApplicationController

  def index
    customers = Customer.all

    respond_to do |format|
      format.json {render json: {customers: customers}, status: :ok}
      format.xml {render xml: customers.as_json}
    end
  end

  def create
    customer = Customer.new(customer_params)

    if customer.save
      respond_to do |format|
        format.json {render json: {customer: customer}, status: :created}
        format.xml {render xml: customer.as_json}
      end

    else
      render json: {errors: customer.errors}, status: :unprocessable_entity
    end

  end

  def show
    customer = Customer.find(params[:id])

    respond_to do |format|
      format.json {render json: {customer: customer}, status: :ok}
      format.xml {render xml: customer.as_json}
    end

  end

  def update
    customer = Customer.find(params[:id])

    if customer.update(customer_params)
      respond_to do |format|
        format.json {render json: {customer: customer}, status: :ok}
        format.xml {render xml: customer.as_json}
      end
    else
      render json: {errors: customer.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    customer = Customer.find(params[:id])
    customer.destroy
    head 204
  end

  def email
    customer = Customer.find_by(email: params[:email])

    respond_to do |format|
      format.xml {render xml: customer.as_json}
      format.json {render json: {customer: customer}, status: :ok}
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:firstname, :lastname, :preposition, :email, :address_id)
  end
end
