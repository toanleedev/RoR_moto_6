class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :photo_url,
             :phone
  attributes :provider
  # has_many :vehicles
  belongs_to :address_default
  # has_one :paper

  def full_name
    "#{object.last_name} #{object.first_name}"
  end
end
