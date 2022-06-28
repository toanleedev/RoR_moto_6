# == Schema Information
#
# Table name: vehicle_images
#
#  id         :bigint           not null, primary key
#  vehicle_id :bigint           not null
#  image_path :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class VehicleImage < ActiveRecord::Base
  belongs_to :vehicle
  mount_uploader :image_path, PaperUploader
end
