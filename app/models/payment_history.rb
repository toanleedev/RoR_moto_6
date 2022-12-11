# == Schema Information
#
# Table name: payment_histories
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PaymentHistory < ActiveRecord::Base
end
