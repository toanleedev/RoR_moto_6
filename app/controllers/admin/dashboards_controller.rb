module Admin
  class DashboardsController < AdminController
    def show
      @number_of_users = User.all.count
      @number_of_vehicles = Vehicle.where.not(status: :locked).count
      @orders_completed_count = Order.all.select(&:completed?).count
    end
  end
end
