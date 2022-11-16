module Admin
  class OrdersController < AdminController
    def index
      @orders = Order.order('orders.created_at DESC').all

      respond_to do |format|
        format.html
        format.json { render json: @orders }
      end
    end

    def show
      @order = Order.includes(:vehicle).find_by(id: params[:id])
    end
  end
end
