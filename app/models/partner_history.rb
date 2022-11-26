# == Schema Information
#
# Table name: partner_histories
#
#  id          :bigint           not null, primary key
#  full_name   :string
#  phone       :string
#  email       :string
#  address     :string
#  title       :string
#  description :string
#  tax_code    :string
#  user_kind   :integer          default(NULL)
#  status      :integer          default("pending")
#  user_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class PartnerHistory < ActiveRecord::Base
  belongs_to :user
  validates :full_name, :phone, :title, :description, :email, :address, presence: true, length: { minimum: 2 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :phone, presence: true, numericality: true, length: { minimum: 10, maximum: 15 }

  enum user_kind: {
    personal: 1,
    company: 2
  }
  enum status: {
    pending: 0,
    confirmed: 1,
    canceled: 2
  }
end
