class OrdersController < ApplicationController
  def create
  end

  private

  def order_params
    params.require(:order).permit(:start_date, :end_date)
  end
end
