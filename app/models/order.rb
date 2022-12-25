# == Schema Information
#
# Table name: orders
#
#  id                 :bigint           not null, primary key
#  start_date         :datetime
#  end_date           :datetime
#  rental_times       :float
#  amount             :decimal(18, )
#  status             :integer          default("opening")
#  confirmation_token :string
#  is_home_delivery   :boolean          default(FALSE)
#  delivery_address   :string
#  vehicle_id         :bigint           not null
#  renter_id          :bigint
#  owner_id           :bigint
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  confirmed_at       :datetime
#  processing_at      :datetime
#  completed_at       :datetime
#  uid                :string
#  price              :decimal(18, )
#  amount_include_fee :decimal(18, )
#  service_fee        :decimal(18, )
#
class Order < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  belongs_to :renter, class_name: 'User'
  belongs_to :vehicle
  before_create :default_values
  has_one :vehicle_rating, -> { where ratingable_type: 'Vehicle' },
          class_name: 'Rating'
  has_one :renter_rating, -> { where ratingable_type: 'User' }, class_name: 'Rating'
  has_one :payment, as: :paymentable

  accepts_nested_attributes_for :vehicle, :payment, :owner

  enum status: {
    opening: 0,
    pending: 1,
    accepted: 2,
    processing: 3,
    completed: 4,
    canceled: 5
  }

  enum payment_kind: {
    cash: 0,
    bank_transfer: 1
  }

  scope :already_order, -> { where.not(status: %i[completed canceled]) }
  scope :has_completed, -> { where(status: :completed) }

  def payment_method
    payment.payment_kind
  end

  def bank_transfer_payment?
    payment.bank_transfer?
  end

  def cash_payment?
    payment.cash?
  end

  protected

  def default_values
    self.confirmation_token = SecureRandom.urlsafe_base64
    self.uid ||= "MOTO#{SecureRandom.alphanumeric(10).upcase}"
  end
end
