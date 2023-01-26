class BuildOrders
  def initialize(params, options = {})
    @params = params
    @current_user = options[:user]
  end

  attr_reader :params, :current_user

  def save
    ActiveRecord::Base.transaction do
      order = Order.new params
      order.vehicle.status = :rented
      order.payment.user_id = current_user.id
      order.save!
      send_mail_confirm(order)
      SendNotification.new(order).order_create
      CancelUnconfirmedOrderJob.set(wait: 15.minutes).perform_later(order)
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
