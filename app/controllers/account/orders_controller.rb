module Account
  class OrdersController < ::OrdersController
    before_action :set_order, only: %i[edit show update cancel]

    def index
      @orders = OrdersFilter.new(params, current_user).filter
    end

    def cancel
      @order.status = :canceled
      if @order.save
        flash[:notice] = t('message.success.update')
        redirect_to account_orders_path
      else
        flash[:alert] = t('message.failure.update')
        redirect_to request.referrer
      end
    end

    private

    def set_order
      @order = current_user.orders.includes(:vehicle).find_by(id: params[:id])
    end
  end
end
