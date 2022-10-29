class SendNotificationJob < ApplicationJob
  queue_as :default

  def perform(params)
    Notification.create(params)
  end
end
