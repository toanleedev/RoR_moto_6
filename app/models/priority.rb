# == Schema Information
#
# Table name: priorities
#
#  id          :bigint           not null, primary key
#  vehicle_id  :bigint           not null
#  rank        :integer          default("silver")
#  duration    :integer
#  amount      :decimal(18, )
#  expiry_date :datetime
#  status      :integer          default("offline")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Priority < ActiveRecord::Base
  belongs_to :vehicle
  has_one :payment, as: :paymentable

  accepts_nested_attributes_for :payment

  enum rank: {
    silver: 0,
    gold: 1,
    diamon: 2
  }

  enum status: {
    offline: 0,
    online: 1,
    canceled: 2
  }

  def subscribed?
    Time.current < expiry_date
  end
end
