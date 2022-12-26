module Admin
  class DashboardsController < AdminController
    def show
      @number_of_users = User.all.count
      @number_of_vehicles = Vehicle.where.not(status: :locked).count
      @orders_completed_count = Order.all.select(&:completed?).count
      @turnover = PaymentHistory.where.not(action_kind: :order_income).map(&:amount).inject(0, :+)
    end
  end
end
