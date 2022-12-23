# == Schema Information
#
# Table name: payment_histories
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PaymentHistory < ActiveRecord::Base
  enum money_kind: {
    income: 1,
    expense: 2
  }

  enum action_kind: {
    created: 1,
    edited: 2,
    created_when_import: 3
  }
end
