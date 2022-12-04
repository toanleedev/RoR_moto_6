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
class VehicleSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :year_produce,
             :status, :brand, :created_at
  belongs_to :user

  def brand
    object.brand.name_vi
  end

  def type
    object.type.name_vi
  end

  def engine
    object.engine.name_vi
  end
end
