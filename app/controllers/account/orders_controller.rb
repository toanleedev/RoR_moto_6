module Account
  class OrdersController < ::OrdersController
    before_action :set_order, except: %i[index create]

    def index
      @orders = OrdersFilter.new(params, current_user).filter
    end

    def cancel
      @order.status = :canceled
      save_order @order
    end

    def accept
      @order.status = :accepted
      save_order @order
    end

    def processing
      @order.status = :processing
      save_order @order
    end

    def completed
      @order.status = :completed
      save_order @order
    end

    def pending
      @order.status = :pending
      save_order @order
    end

    private

    def set_order
      @order = current_user.orders.includes(:vehicle).find_by(id: params[:id])
    end

    def save_order(order)
      if order.save
        flash[:notice] = t('message.success.update')
        redirect_to account_orders_path
      else
        flash[:alert] = t('message.failure.update')
        redirect_to request.referrer
      end
    end
  end
end
