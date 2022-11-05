class BuildOrders
  def initialize(params, _options = {})
    @params = params
  end

  attr_reader :params

  def save
    ActiveRecord::Base.transaction do
      order = Order.new params
      order.vehicle.status = :reserved
      order.save!
      send_mail_confirm(order)
      SendNotification.new(order).order_create
      ServiceResult.new(success: true, data: order)
    end
  rescue StandardError => e
    ServiceResult.new(success: false, errors: [e])
  end

  private

  def send_mail_confirm(order)
    OrderMailer.order_confirmation(order).deliver_now
  end
end
