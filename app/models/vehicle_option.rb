# == Schema Information
#
# Table name: vehicle_options
#
#  id      :bigint           not null, primary key
#  key     :string
#  name_vi :string
#  name_en :string
#
class VehicleOption < ActiveRecord::Base
  has_many :vehicles, foreign_key: 'brand_id', dependent: :destroy
  has_many :vehicles, foreign_key: 'type_id', dependent: :destroy
  has_many :vehicles, foreign_key: 'engine_id', dependent: :destroy

  # enum :key, %i[BRAND ENGINE TYPE]

  scope :brands, -> { where key: 'BRAND' }
  scope :engines, -> { where key: 'ENGINE' }
  scope :types, -> { where key: 'TYPE' }
end
