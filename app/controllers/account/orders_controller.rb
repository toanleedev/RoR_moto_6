module Account
  class OrdersController < ::OrdersController
    before_action :set_order, except: %i[index create]

    def index
      @orders = OrdersFilter.new(params, current_user).filter
    end

    def show; end

    def cancel
      @order.status = :canceled
      @order.vehicle.status = :idle
      save_order @order
    end

    private

    def set_order
      @order = current_user.orders.includes(:vehicle).find_by(id: params[:id])
    end

    def save_order(order)
      if order.save
        flash[:notice] = t('message.success.update')
        redirect_to account_order_path(order)
      else
        flash[:alert] = t('message.failure.update')
        redirect_to request.referrer
      end
    end
  end
end
