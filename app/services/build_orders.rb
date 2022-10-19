class BuildOrders
  CONST = 1000
  def initialize(params, _options = {})
    @params = params
  end

  attr_reader :params

  def save
    order = Order.new params
    order.vehicle.status = :reserved
    if order.save
      OrderMailer.order_confirmation(order).deliver_now
      send_notification(order)
      ServiceResult.new(success: true, data: order)
    else
      ServiceResult.new(success: false, data: order)
    end
  end

  private

  def send_notification(order)
    # SendNotificationJob.perform_now('CreateOrder', Order.last)
  end
end
