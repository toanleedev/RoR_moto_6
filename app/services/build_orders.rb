class BuildOrders
  ORDER_URL = 'account/orders'.freeze
  RENTAL_ORDER_URL = 'account/rental_orders'.freeze
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
      send_notification(order)
      ServiceResult.new(success: true, data: order)
    end
  rescue StandardError => e
    ServiceResult.new(success: false, errors: [e])
  end

  private

  def send_mail_confirm(order)
    OrderMailer.order_confirmation(order).deliver_now
  end

  def send_notification(order)
    notification_params = []
    renter_params = {
      receiver_id: order[:renter_id],
      on_click_url: "#{ORDER_URL}/#{order[:id]}",
      title: 'notification.title.new_order_confirm',
      content: 'notification.content.new_order_confirm'
    }
    owner_params = {
      receiver_id: order[:owner_id],
      on_click_url: "#{RENTAL_ORDER_URL}/#{order[:id]}",
      title: 'notification.title.new_order',
      content: 'notification.content.new_order'
    }
    notification_params << renter_params
    notification_params << owner_params

    BulkSendNotification.perform_now(notification_params)
  end
end
