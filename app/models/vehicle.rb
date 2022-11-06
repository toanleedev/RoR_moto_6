# == Schema Information
#
# Table name: vehicles
#
#  id           :bigint           not null, primary key
#  user_id      :bigint           not null
#  description  :text
#  price        :decimal(, )
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  brand_id     :bigint
#  type_id      :bigint
#  engine_id    :bigint
#  name         :string
#  status       :integer          default("idle")
#  year_produce :integer
#
class Vehicle < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :brand, class_name: 'VehicleOption', foreign_key: 'brand_id'
  belongs_to  :type, class_name: 'VehicleOption', foreign_key: 'type_id'
  belongs_to  :engine, class_name: 'VehicleOption', foreign_key: 'engine_id'
  has_many :vehicle_images, dependent: :destroy
  has_many :orders
  has_many :ratings, -> { where rate_kind: :vehicle }, through: :orders

  accepts_nested_attributes_for :vehicle_images

  enum status: {
    idle: 0,
    reserved: 1,
    hidden: 3,
    locked: 4
  }
end
