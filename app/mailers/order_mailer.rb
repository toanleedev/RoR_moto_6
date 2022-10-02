class OrderMailer < ApplicationMailer
  def order_confirmation(order)
    @order = order
    mail to: order.renter.email, subject: t('.order_subject')
  end
end
