class V1::OrdersController < ApplicationController

  def index
    if params[:customer_id]
      customer = Customer.find(params[:customer_id])
      orders = customer.orders
    else
      orders = Order.all
    end

    render json: {orders: orders}, status: :ok
  end

  def create
    customer = Customer.find(params[:customer_id])
    order = customer.orders.new(product_params)

    if order.save
      render json: {order: order}, status: :created
    else
      render json: {errors: order.errors}, status: :unprocessable_entity
    end

  end

  def show
    if params[:customer_id]
      customer = Customer.find(params[:customer_id])
      order = customer.orders.find(params[:id])
    else
      order = Order.find(params[:id])
    end

    render json: {order: order}, status: :ok
  end

  def update
    if params[:customer_id]
      customer = Customer.find(params[:customer_id])
      order = customer.orders.find(params[:id])
    else
      order = Order.find(params[:id])
    end

    if order.update(order_params)
      render json: {order: order}, status: :ok
    else
      render json: {errors: order.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    if params[:customer_id]
      customer = Customer.find(params[:customer_id])
      order = customer.orders.find(params[:id])
    else
      order = Order.find(params[:id])
    end

    order.destroy
    head 204
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
