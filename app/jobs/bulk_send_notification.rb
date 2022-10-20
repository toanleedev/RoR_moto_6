class BulkSendNotification < ApplicationJob
  queue_as :default

  def perform(params)
    time_current = {
      created_at: Time.current,
      updated_at: Time.current
    }

    params.each { |p| p.merge!(time_current) }
    Notification.insert_all(params)
  end
end
