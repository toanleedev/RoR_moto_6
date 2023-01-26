# == Schema Information
#
# Table name: ratings
#
#  id              :bigint           not null, primary key
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
end
