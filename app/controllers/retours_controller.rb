class RetoursController < ApplicationController

  def index
    if params[:customer_id]
      customer = Customer.find(params[:customer_id])
      retours = customer.retours
    else
      retours = Retour.all
    end

    respond_to do |format|
      format.json {render json: {retours: retours}, status: :ok}
      format.xml {render xml: retours.as_json}
    end
  end

  def create
    customer = Customer.find(params[:customer_id])
    retour = customer.retours.new(retour_params0)

    if retour.save
      respond_to do |format|
        format.json {render json: {retour: retour}, status: :created}
        format.xml {render xml: retour.as_json}
      end
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

    respond_to do |format|
      format.json {render json: {retour: retour}, status: :ok}
      format.xml {render xml: retour.as_json}
    end
  end

  def bizagi
    p params[:retour_lines]
    if !request.headers['Content-Type'].blank?

      p request.headers['Content-Type']
    else
      p "HELP BIZAGI HOUDT MIJ GIJZELAAR"
      p "XX" + request.headers['Content-Type'] + "XX"
    end
    customer = Customer.find(params[:customer_id])
    retour = customer.retours.create(status: "Niet gepland")

    params[:_json].each do |line|
      product = Product.find(line[:product_id])
      amount = line[:amount]
      order_line = OrderLine.find(line[:order_line_id])

      retour.retour_lines.create(product: product, amount: amount)
      order_line.returned = true
      order_line.save
    end

  end

  def update
    if params[:customer_id]
      customer = Customer.find(params[:customer_id])
      retour = customer.retours.find(params[:id])
    else
      retour = Retour.find(params[:id])
    end

    if retour.update(retour_params)
      respond_to do |format|
        format.json {render json: {retour: retour}, status: :ok}
        format.xml {render xml: retour.as_json}
      end
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
    params.permit(:customer_id, :status, :id)
  end

end
