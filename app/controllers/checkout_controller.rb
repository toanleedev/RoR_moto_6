class CheckoutController < ApplicationController
  def index
    @order_params = params
  end

  def confirm
    @vehicle_params = params
    render 'index', locals: @vehicle_params
  end
end
