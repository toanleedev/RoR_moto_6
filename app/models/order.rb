# == Schema Information
#
# Table name: orders
#
#  id                 :bigint           not null, primary key
#  start_date         :datetime
#  end_date           :datetime
#  count_rental_days  :integer
#  amount             :decimal(18, )
#  message            :string
#  status             :integer          default("open")
#  confirmation_token :string
#  is_confirmed       :boolean          default(FALSE)
#  is_home_delivery   :boolean          default(FALSE)
#  delivery_address   :string
#  is_prepaid         :boolean          default(FALSE)
#  prepaid_discount   :decimal(18, )
#  payment            :string           default("cash"), not null
#  payment_info       :string
#  is_paid            :boolean          default(FALSE)
#  discount           :decimal(18, )
#  vehicle_id         :bigint           not null
#  renter_id          :bigint
#  owner_id           :bigint
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Order < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  belongs_to :renter, class_name: 'User'
  belongs_to :vehicle

  enum status: {
    open: 0,
    accepted: 1,
    processing: 2,
    completed: 3,
    pending: 4,
    canceled: 5
  }
end
