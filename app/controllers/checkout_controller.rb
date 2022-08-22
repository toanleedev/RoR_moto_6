class CheckoutController < ApplicationController
  before_action :get_vehicle

  def confirm
    # check params lai cho nay
    @vehicle_params = params
    @order = Order.new
    render 'confirm', locals: { vehicle: @vehicle }, collection: @order
  end

  private

  def get_vehicle
    @vehicle = Vehicle.includes(:brand, :type, :engine, :user)
                      .find_by(id: params[:vehicle_id])
  end
end
