module Account
  class RentalOrdersController < ::OrdersController
    before_action :set_order, except: %i[index create]
    before_action :set_is_rental_page

    def index
      @orders = OrdersFilter.new(params, current_user).filter_rental
      render 'account/orders/index'
    end

    def show
      render 'account/orders/show'
    end

    def edit
      render 'account/orders/edit'
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
      @order.processing_at = Time.current
      save_order @order
    end

    def completed
      @order.status = :completed
      @order.completed_at = Time.current
      save_order @order
    end

    private

    def set_order
      @order = current_user.rental_orders.includes(:vehicle).find_by(id: params[:id])
    end

    def set_is_rental_page
      @is_rental_page = true
    end

    def save_order(order)
      if order.save
        flash[:notice] = t('message.success.update')
        redirect_to account_rental_order_path(order)
      else
        flash[:alert] = t('message.failure.update')
        redirect_to request.referrer
      end
    end
  end
end
