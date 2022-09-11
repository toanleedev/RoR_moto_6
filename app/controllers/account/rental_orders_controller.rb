module Account
  class RentalOrdersController < ::OrdersController
    before_action :set_order, only: %i[edit show update cancel]
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

    private

    def set_order
      @order = current_user.rental_orders.includes(:vehicle).find_by(id: params[:id])
    end

    def set_is_rental_page
      @is_rental_page = true
    end
  end
end
