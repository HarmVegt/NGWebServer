class RetourLinesController < ApplicationController

  def index
    if params[:customer_id] && params[:retour_id]
      customer = Customer.find(params[:customer_id])
      retour = customer.retours.find(params[:retour_id])
      retour_lines = retour.retour_lines
    else
      retour_lines = RetourLine.all
    end
    render json: {retour_lines: retour_lines}, status: :ok
  end

  def create
    customer = Customer.find(params[:customer_id])
    retour = customer.retours.find(params[:retour_id])
    retour_line = retour.retour_lines.new(retour_line_params)

    if retour_line.save
      render json: {retour_line: retour_line}, status: :created
    else
      render json: {errors: retour_line.errors}, status: :unprocessable_entity
    end

  end

  def show
    if params[:customer_id] && params[:order_id]
      customer = Customer.find(params[:customer_id])
      retour = customer.retours.find(params[:retour_id])
      retour_line = retour.retour_lines.find(params[:id])
    else
      retour_line = RetourLine.find(params[:id])
    end
    render json: {retour_line: retour_line}, status: :ok
  end

  def update
    if params[:customer_id] && params[:retour_id]
      customer = Customer.find(params[:customer_id])
      retour = customer.retours.find(params[:retour_id])
      retour_line = retour.retour_lines.find(params[:id])
    else
      retour_line = RetourLine.find(params[:id])
    end

    if retour_line.update(retour_line_params)
      render json: {retour_line: retour_line}, status: :ok
    else
      render json: {errors: retour_line.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    if params[:customer_id] && params[:retour_id]
      customer = Customer.find(params[:customer_id])
      retour = customer.retours.find(params[:retour_id])
      retour_line = retour.retour_lines.find(params[:id])
    else
      retour_line = RetourLine.find(params[:id])
    end
    retour_line.destroy
    head 204
  end

  private

  def retour_line_params
    params.require(:retour_line).permit(:amount)
  end

end
