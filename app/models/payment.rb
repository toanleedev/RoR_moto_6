# == Schema Information
#
# Table name: payments
#
#  id               :bigint           not null, primary key
#  paymentable_type :string
#  paymentable_id   :bigint
#  user_id          :bigint           not null
#  payment_kind     :integer
#  payment_security :string
#  paid_at          :datetime
#  amount           :decimal(18, )
#  status           :integer          default("pending")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Payment < ActiveRecord::Base
  belongs_to :paymentable, polymorphic: true
  belongs_to :user
  has_one :payment_history

  enum payment_kind: {
    cash: 0,
    bank_transfer: 1,
    balance: 2
  }

  enum status: {
    pending: 0,
    completed: 1
  }
end
