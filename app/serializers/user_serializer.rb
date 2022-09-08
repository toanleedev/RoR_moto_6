class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :phone

  attribute :phone, if: :phone_condition?
  # has_many :vehicles
  belongs_to :address_default
  # has_one :paper

  def full_name
    "#{object.last_name} #{object.first_name}"
  end

  def phone_condition?
    object.phone.present?
  end

  # def user
  #   object.user.to_json(only: [ :id, :profile_url ])
  # end
end
