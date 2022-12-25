module Partners
  class StatisticsController < ApplicationController
    before_action :authenticate_user!
    layout 'partner'

    def show
      order_has_completed = current_user.order_manages.has_completed
      @turnover_total = order_has_completed.map(&:amount).inject(0, :+)
      @order_completed_count = order_has_completed.count
      @vehicle_count = current_user.vehicles.count
    end
  end
end
