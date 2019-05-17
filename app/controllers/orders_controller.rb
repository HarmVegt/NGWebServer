class OrdersController < ApplicationController

  def index
    if params[:customer_id]
      customer = Customer.find(params[:customer_id])
      orders = customer.orders
    else
      orders = Order.all
    end

    respond_to do |format|
      format.json {render json: {orders: orders}, status: :ok}
      format.xml {render xml: orders.as_json}
    end
  end

  def bizagi
    customer = Customer.find(params[:customer_id])
    orders = customer.orders.where(status: "Bezorgd")
    render xml: orders.as_json
  end

  def create
    customer = Customer.find(params[:customer_id])
    order = customer.orders.new(product_params)

    if order.save
      respond_to do |format|
        format.json {render json: {order: order}, status: :created}
        format.xml {render xml: order.as_json}
      end
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

    respond_to do |format|
      format.json {render json: {order: order}, status: :ok}
      format.xml {render xml: order.as_json}
    end
  end

  def update
    if params[:customer_id]
      customer = Customer.find(params[:customer_id])
      order = customer.orders.find(params[:id])
    else
      order = Order.find(params[:id])
    end

    if order.update(order_params)
      respond_to do |format|
        format.json {render json: {order: order}, status: :ok}
        format.xml {render xml: order.as_json}
      end
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
