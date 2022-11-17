# == Schema Information
#
# Table name: notifications
#
#  id           :bigint           not null, primary key
#  sender_id    :bigint
#  receiver_id  :bigint
#  title        :string
#  content      :text
#  on_click_url :string
#  checked_at   :datetime
#  notify_type  :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Notification < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  scope :count_unread, -> { where(checked_at: nil).count }

  enum notify_type: {
    user: 0,
    admin: 1,
    announcement: 2
  }

  after_create :send_notification

  def send_notification
    NotificationBroadcastJob.perform_now(self)
  end
end
