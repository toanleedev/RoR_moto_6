class OrdersController < ApplicationController
  layout 'account'
  before_action :authenticate_user!

  def create
    order = Order.new order_params
    if order.save
      flash[:notice] = t('message.success.create')
      redirect_to root_path
      # redirect_to order/complete
    else
      flash[:alert] = t('message.failure.create')
    end
  end

  def show; end

  def edit; end

  def update
    if @order.update order_update_params
      flash[:notice] = t('message.success.update')
      redirect_to account_order_path(@order)
      # rental_order update bi loi
    else
      flash[:alert] = t('message.failure.update')
      redirect_to request.referrer
    end
  end

  private

  def order_params
    params.require(:order).permit(:start_date, :end_date, :count_rental_days,
                                  :vehicle_id, :is_home_delivery, :unit_price,
                                  :delivery_address, :amount, :payment, :owner_id).to_h.deep_merge(
                                    renter_id: current_user.id
                                  )
  end

  def order_update_params
    params.require(:order).permit(:start_date, :end_date, :is_home_delivery,
                                  :delivery_address, :count_rental_days, :amount)
  end
end
