module Account
  class RentalOrdersController < ::OrdersController
    before_action :set_order, only: %i[edit show update cancel]

    def index
      @orders = current_user.rental_orders.includes(:vehicle)
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
  end
end
