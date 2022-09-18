module Admin
  class OrdersController < AdminController
    def index
      @orders = Order.order('orders.created_at DESC').all

      respond_to do |format|
        format.html
        format.json { render json: @orders }
      end
    end
  end
end
