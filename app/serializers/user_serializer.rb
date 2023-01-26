# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  photo_url              :text
#  birth                  :datetime
#  phone                  :string
#  gender                 :integer
#  is_partner             :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  provider               :string
#  uid                    :string
#  is_admin               :boolean
#  status                 :integer          default("online")
#
class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :full_name, :phone

  attribute :phone, if: :phone_condition?
  # has_many :vehicles
  has_one :address
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
