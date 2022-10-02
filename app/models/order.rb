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
#  status             :integer          default("opening")
#  confirmation_token :string
#  is_home_delivery   :boolean          default(FALSE)
#  delivery_address   :string
#  is_prepaid         :boolean          default(FALSE)
#  prepaid_discount   :decimal(18, )
#  payment_info       :string
#  discount           :decimal(18, )
#  vehicle_id         :bigint           not null
#  renter_id          :bigint
#  owner_id           :bigint
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  confirmed_at       :datetime
#  processing_at      :datetime
#  completed_at       :datetime
#  paid_at            :datetime
#  uid                :string
#  payment            :integer          default("cash"), not null
#
class Order < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  belongs_to :renter, class_name: 'User'
  belongs_to :vehicle
  before_create :default_values

  enum status: {
    opening: 0,
    pending: 1,
    accepted: 2,
    processing: 3,
    completed: 4,
    canceled: 5
  }

  enum payment: {
    cash: 0,
    paypal: 1
  }

  protected

  def default_values
    self.confirmation_token = SecureRandom.urlsafe_base64
    self.uid ||= "MOTO#{SecureRandom.alphanumeric(10).upcase}"
  end
end
