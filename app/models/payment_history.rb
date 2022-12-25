# == Schema Information
#
# Table name: payment_histories
#
#  id            :bigint           not null, primary key
#  userable_type :string
#  userable_id   :bigint
#  payment_id    :bigint
#  money_kind    :integer          default(NULL)
#  action_kind   :integer          default("top_up")
#  amount        :decimal(18, )
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class PaymentHistory < ActiveRecord::Base
  belongs_to :userable, polymorphic: true
  belongs_to :payment

  enum money_kind: {
    income: 1,
    expense: 2
  }

  enum action_kind: {
    top_up: 0,
    service_fee: 1,
    priority_fee: 2,
    slot_fee: 3
  }
end
