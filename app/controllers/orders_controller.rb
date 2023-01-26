class OrdersController < ApplicationController
  layout 'account'
  before_action :authenticate_user!

  def create
    vehicle = Vehicle.find_by(id: order_params[:vehicle_id])
    return redirect_to search_path, flash: { alert: t('.vehicle_not_available') } unless
      vehicle.present? && vehicle.idle?

    order = BuildOrders.new(order_params, user: current_user).save

    if order.success?
      flash[:notice] = t('message.success.create')
      redirect_to checkout_complete_path(uid: order.data.uid)
    else
      flash[:alert] = t('message.failure.create')
      redirect_to root_path
    end
  end

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
    params.require(:order).permit(:start_date, :end_date, :rental_times,
                                  :vehicle_id, :is_home_delivery, :price,
                                  :delivery_address, :amount, :payment_kind,
                                  :owner_id, payment_attributes: [:payment_kind]).to_h.deep_merge(
                                    renter_id: current_user.id
                                  )
  end

  def order_update_params
    params.require(:order).permit(:start_date, :end_date, :is_home_delivery,
                                  :delivery_address, :rental_times, :amount)
  end
end
