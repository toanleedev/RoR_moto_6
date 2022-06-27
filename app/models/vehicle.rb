class Vehicle < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :brand, class_name: 'VehicleOption', foreign_key: 'brand_id'
  belongs_to  :type, class_name: 'VehicleOption', foreign_key: 'type_id'
  belongs_to  :engine, class_name: 'VehicleOption', foreign_key: 'engine_id'
  has_many :vehicle_images, dependent: :destroy

  accepts_nested_attributes_for :vehicle_images
end
