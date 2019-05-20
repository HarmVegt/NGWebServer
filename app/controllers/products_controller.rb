class ProductsController < ApplicationController

  def index
    if params[:customer_id]
      customer = Customer.find(params[:customer_id])
      products = customer.products
    else
      products = Product.all
    end

    respond_to do |format|
      format.json {render json: {products: products}, status: :ok}
      format.xml {render xml: products.as_json}
    end
  end

  def create
    if params[:customer_id] && params[:order_id] && params[:order_line_id]
      customer = Customer.find(params[:customer_id])
      order = customer.orders.find(params[:order_id])
      order_line = order.order_lines.find(params[:order_line_id])
      product = order_line.product
    else
      product = Product.find(params[:id])
    end

    if product.save
      respond_to do |format|
        format.json {render json: {product: product}, status: :created}
        format.xml {render xml: product.as_json}
      end
    else
      render json: {errors: product.errors}, status: :unprocessable_entity
    end

  end

  def show
    if params[:customer_id] && params[:order_id] && params[:order_line_id]
      customer = Customer.find(params[:customer_id])
      order = customer.orders.find(params[:order_id])
      order_line = order.order_lines.find(params[:order_line_id])
      product = order_line.product
    else
      product = Product.find(params[:id])
    end
    respond_to do |format|
      format.json {render json: {product: product}, status: :ok}
      format.xml {render xml: product.as_json}
    end
  end

  def update
    if params[:customer_id] && params[:order_id] && params[:order_line_id]
      customer = Customer.find(params[:customer_id])
      order = customer.orders.find(params[:order_id])
      order_line = order.order_lines.find(params[:order_line_id])
      product = order_line.product
    else
      product = Product.find(params[:id])
    end

    if product.update(product_params)
      respond_to do |format|
        format.json {render json: {product: product}, status: :ok}
        format.xml {render xml: product.as_json}
      end
    else
      render json: {errors: product.errors}, status: :unprocessable_entity
    end
  end

  def increase_amount
    params[:_json].each do |retour|
      product = Product.find(retour[:product_id])
      amount = product.amount
      product.amount = product.amount + retour[:amount]
      product.save
      p "Previous: #{amount}"
      p "New: #{product.amount}"
    end
  end

  def destroy
    if params[:customer_id] && params[:order_id] && params[:order_line_id]
      customer = Customer.find(params[:customer_id])
      order = customer.orders.find(params[:order_id])
      order_line = order.order_lines.find(params[:order_line_id])
      product = order_line.product
      product = nil
      head 204
    else
      product = Product.find(params[:id])
      product.destroy
    end
    head 204
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :amount, :price)
  end

end
