class CheckoutController < ApplicationController
  def index
  end

  def confirm
    # check params lai cho nay
    @vehicle_params = params
    @order = Order.new
    @vehicle = Vehicle.includes(:brand, :type, :engine).find_by(id: params[:vehicle_id])
    render 'confirm', locals: { vehicle: @vehicle }, collection: @order
  end
end
