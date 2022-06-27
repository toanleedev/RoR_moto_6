class VehicleImage < ActiveRecord::Base
  belongs_to :vehicle
  mount_uploader :image_path, PaperUploader
end
