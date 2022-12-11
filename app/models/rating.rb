# == Schema Information
#
# Table name: ratings
#
#  id              :bigint           not null, primary key
#  rate_kind       :integer          default("vehicle")
#  rating_point    :integer
#  content         :text
#  reviewer_id     :bigint
#  order_id        :bigint           not null
#  ratingable_type :string
#  ratingable_id   :bigint
#
class Rating < ActiveRecord::Base
  belongs_to :reviewer, class_name: 'User'
  belongs_to :order
  belongs_to :ratingable, polymorphic: true

  enum rate_kind: {
    vehicle: 0,
    user: 1
  }
end
