# == Schema Information
#
# Table name: ratings
#
#  id           :bigint           not null, primary key
#  rate_kind    :integer          default(0)
#  rating_point :integer
#  content      :text
#  reviewer_id  :bigint
#  order_id     :bigint           not null
#
class Rating < ActiveRecord::Base
  belongs_to :reviewer, class_name: 'User'
  belongs_to :order

  enum rate_kind: {
    vehicle: 0,
    user: 1
  }
end
