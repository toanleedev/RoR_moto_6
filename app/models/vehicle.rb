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
#  status       :integer          default("opening")
#  year_produce :integer
#
class Vehicle < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :brand, class_name: 'VehicleOption', foreign_key: 'brand_id'
  belongs_to  :type, class_name: 'VehicleOption', foreign_key: 'type_id'
  belongs_to  :engine, class_name: 'VehicleOption', foreign_key: 'engine_id'
  has_many :vehicle_images, dependent: :destroy, inverse_of: :vehicle
  has_many :orders
  has_many :ratings, through: :orders, source: :vehicle_rating
  has_many :priorities, -> { where status: 'online' }
  has_one :subscribe_priority, -> { where expiry_date: Time.current.. }, class_name: 'Priority'

  validates :description, :name, :brand_id, :type_id, :engine_id, presence: true
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 10_000_000 }

  accepts_nested_attributes_for :vehicle_images, :priorities

  enum status: {
    opening: 0,
    accepted: 1,
    idle: 2,
    rented: 3,
    locked: 4,
    offline: 5
  }

  def average_rating
    arr_points = ratings.pluck(:rating_point)
    arr_points.reduce(:+).to_f / arr_points.size
  end

  def full_name
    "#{brand.name_vi} #{name}"
  end

  def lastest_subscribe_priority
    priorities.last
  end
end
