# == Schema Information
#
# Table name: partners
#
#  id            :bigint           not null, primary key
#  user_id       :bigint           not null
#  name          :string
#  phone         :string
#  email         :string
#  address       :string
#  title         :string
#  description   :string
#  tax_code      :string
#  balance       :decimal(18, )    default(0)
#  user_kind     :integer          default(NULL)
#  status        :integer          default("pending")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  vehicle_limit :integer          default(2)
#
class Partner < ActiveRecord::Base
  belongs_to :user
  has_many :payment_histories, as: :userable
  validates :name, :phone, :title, :description, :email, :address, presence: true, length: { minimum: 2 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :phone, presence: true, numericality: true, length: { minimum: 10, maximum: 15 }

  accepts_nested_attributes_for :payment_histories

  enum user_kind: {
    personal: 1,
    company: 2
  }
  enum status: {
    pending: 0,
    confirmed: 1,
    canceled: 2,
    blocked: 4
  }
end
