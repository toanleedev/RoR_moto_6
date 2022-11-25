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
  has_many :vehicles, foreign_key: 'brand_id', dependent: :restrict_with_error
  has_many :vehicles, foreign_key: 'type_id', dependent: :restrict_with_error
  has_many :vehicles, foreign_key: 'engine_id', dependent: :restrict_with_error
  validates :key, :name_vi, :name_en, presence: true

  # enum :key, %i[BRAND ENGINE TYPE]

  before_destroy :ensure_not_referenced

  scope :brands, -> { where key: 'BRAND' }
  scope :engines, -> { where key: 'ENGINE' }
  scope :types, -> { where key: 'TYPE' }

  private

  def ensure_not_referenced
  end
end
