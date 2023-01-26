namespace :build do
  desc 'TODO'
  task payment_order: :environment do
    Order.all.each do |order|
      break if order.payment.present?

      order.build_payment
      order.payment.payment_kind = order.payment_kind
      order.payment.user_id = order.renter_id
      order.payment.payment_kind = order.payment_kind
      order.payment.payment_security = order.payment_security
      order.payment.amount = order.amount
      if order.paid_at.present?
        order.payment.paid_at = order.paid_at
        order.payment.status = :completed
      end
      order.save
    end
  end

  task service_fee_order: :environment do
    Order.all.each do |order|
      break if order.amount_include_fee.present?

      order.service_fee = o.amount * 0.05
      order.amount_include_fee = o.amount - o.service_fee
      order.save
    end
  end

  task add_price_vehicle_to_order: :environment do
    Order.all.each do |order|
      break if order.price.present?

      order.price = order.vehicle.price
      order.save
    end
  end
end
