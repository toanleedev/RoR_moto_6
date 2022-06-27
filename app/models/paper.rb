class Paper < ActiveRecord::Base
  belongs_to  :user
  mount_uploader :card_front_url, PaperUploader
  mount_uploader :card_back_url, PaperUploader
  mount_uploader :driver_front_url, PaperUploader
  mount_uploader :other_license_url, PaperUploader
end
