class CancelUnconfirmedOrderJob < ApplicationJob
  queue_as :default
  def perform(order)
    if order.opening?
      order.status = :canceled
      order.vehicle.status = :idle

      order.save!
    else
      # Gui thong bao den partner
    end
  end
end
