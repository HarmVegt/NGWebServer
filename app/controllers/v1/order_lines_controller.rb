class V1::OrderLinesController < ApplicationController

  def index
    if params[:customer_id] && params[:order_id]
      customer = Customer.find(params[:customer_id])
      order = customer.orders.find(params[:order_id])
      order_lines = order.order_lines
    else
      order_lines = OrderLine.all
    end
    render json: {order_lines: order_lines}, status: :ok
  end

  def create
    customer = Customer.find(params[:customer_id])
    order = customer.orders.find(params[:order_id])
    order_line = order.order_lines.new(order_line_params)

    if order_line.save
      render json: {order_line: order_line}, status: :created
    else
      render json: {errors: order_line.errors}, status: :unprocessable_entity
    end

  end

  def show
    if params[:customer_id] && params[:order_id]
      customer = Customer.find(params[:customer_id])
      order = customer.orders.find(params[:order_id])
      order_line = order.order_lines.find(params[:id])
    else
      order_line = OrderLine.find(params[:id])
    end
    render json: {order_line: order_line}, status: :ok
  end

  def update
    if params[:customer_id] && params[:order_id]
      customer = Customer.find(params[:customer_id])
      order = customer.orders.find(params[:order_id])
      order_line = order.order_lines.find(params[:id])
    else
      order_line = OrderLine.find(params[:id])
    end

    if order_line.update(order_line_params)
      render json: {order_line: order_line}, status: :ok
    else
      render json: {errors: order_line.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    if params[:customer_id] && params[:order_id]
      customer = Customer.find(params[:customer_id])
      order = customer.orders.find(params[:order_id])
      order_line = order.order_lines.find(params[:id])
    else
      order_line = OrderLine.find(params[:id])
    end

    order_line.destroy
    head 204
  end

  private

  def order_line_params
    params.require(:order_line).permit(:amount)
  end
end
