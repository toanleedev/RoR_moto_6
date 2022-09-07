class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :photo_url,
             :phone, :gender, :provider

  # has_many :vehicles
  belongs_to :address_default
  has_one :paper
end
