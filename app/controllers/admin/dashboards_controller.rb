module Admin
  class DashboardsController < AdminController
    def show
      @number_of_users = User.all.count
      @number_of_partners = User.where(is_partner: true).count
      @orders_completed_count = Order.all.select(&:completed?).count
    end
  end
end
