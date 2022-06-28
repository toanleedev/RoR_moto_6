# == Schema Information
#
# Table name: papers
#
#  id                 :bigint           not null, primary key
#  user_id            :bigint           not null
#  card_number        :string
#  card_front_url     :text
#  card_back_url      :text
#  driver_number      :string
#  driver_front_url   :text
#  verified_at        :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  is_card_verified   :boolean
#  card_verified_at   :datetime
#  is_driver_verified :boolean
#  driver_verified_at :datetime
#  other_license_url  :text
#
class Paper < ActiveRecord::Base
  belongs_to  :user
  mount_uploader :card_front_url, PaperUploader
  mount_uploader :card_back_url, PaperUploader
  mount_uploader :driver_front_url, PaperUploader
  mount_uploader :other_license_url, PaperUploader
end
