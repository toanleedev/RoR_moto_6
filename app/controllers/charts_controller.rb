class ChartsController < ApplicationController
  def partner_turnover
    turnover_statistic =
      current_user.order_manages
                  .has_completed
                  .group_by_period(params[:period] || 'month',
                                   :completed_at, permit: %w[day week month])
                  .sum(:amount)
    render json: turnover_statistic
  end

  def partner_order
    order_statistic =
      current_user.order_manages
                  .group_by_period(params[:period] || 'month',
                                   :completed_at, permit: %w[day week month])
                  .count
    render json: order_statistic
  end

  def partner_vehicle
    vehicle_partner_statistic =
      current_user.vehicles.joins(:orders).group('name')
                  .group_by_period(params[:period] || 'month',
                                   'orders.completed_at').count
    render json: vehicle_partner_statistic.chart_json
  end
end
