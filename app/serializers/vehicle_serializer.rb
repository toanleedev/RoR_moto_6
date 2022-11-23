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
