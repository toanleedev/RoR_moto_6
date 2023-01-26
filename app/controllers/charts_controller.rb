class ChartsController < ApplicationController
  PERMIT_PERIOD = %w[day week month].freeze
  def partner_turnover
    turnover_statistic =
      current_user.order_manages
                  .has_completed
                  .group_by_period(params[:period] || 'month',
                                   :completed_at, permit: PERMIT_PERIOD)
                  .sum(:amount)
    render json: turnover_statistic
  end

  def partner_order
    order_statistic =
      current_user.order_manages
                  .group_by_period(params[:period] || 'month',
                                   :completed_at, permit: PERMIT_PERIOD)
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

  def admin_statistic # rubocop:disable Metrics/CyclomaticComplexity
    data_chart = []
    chart = params[:chart] || 'users'
    period = params[:period] || 'week'

    case chart
    when 'users' || nil
      data_chart =
        User.all
            .group_by_period(period, :created_at, permit: PERMIT_PERIOD)
            .count
    when 'vehicle'
      data_chart =
        Vehicle.all
               .group_by_period(period, :created_at, permit: PERMIT_PERIOD)
               .count
    when 'order'
      data_chart =
        Order.all
             .group_by_period(period, :completed_at, permit: PERMIT_PERIOD)
             .count
    when 'turnover'
      data_chart =
        PaymentHistory.all
                      .group_by_period(period, :created_at, permit: PERMIT_PERIOD)
                      .sum(:amount)
    end
    render json: data_chart
  end
end
