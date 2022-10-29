class Notification < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  after_create :send_notification

  def send_notification
    NotificationBroadcastJob.perform_now(self)
  end
end
