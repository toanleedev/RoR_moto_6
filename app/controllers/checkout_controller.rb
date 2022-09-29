class CheckoutController < ApplicationController
  before_action :set_vehicle
  before_action :authenticate_user!

  def confirm
    # check params lai cho nay
    @vehicle_params = params
    @order = Order.new
    render 'confirm', locals: { vehicle: @vehicle }, collection: @order
  end

  def complete
    redirect_to root_path unless params[:uid].present?
  end

  private

  def set_vehicle
    @vehicle = Vehicle.includes(:brand, :type, :engine, :user)
                      .find_by(id: params[:vehicle_id])
  end
end
