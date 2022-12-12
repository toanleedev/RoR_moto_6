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
end
