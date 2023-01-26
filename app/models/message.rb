# == Schema Information
#
# Table name: messages
#
#  id          :bigint           not null, primary key
#  sender_id   :bigint
#  receiver_id :bigint
#  content     :text
#  checked_at  :datetime
#
class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :content, presence: true
end
