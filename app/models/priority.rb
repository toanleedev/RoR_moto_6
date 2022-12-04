# == Schema Information
#
# Table name: priorities
#
#  id          :bigint           not null, primary key
#  vehicle_id  :bigint           not null
#  rank        :integer          default(0)
#  duration    :integer
#  amount      :decimal(18, )
#  paid_at     :datetime
#  expiry_date :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Priority < ActiveRecord::Base
  belongs_to :vehicle

  enum rank: {
    silver: 0,
    gold: 1,
    diamon: 2
  }

  enum status: {
    offline: 0,
    online: 1
  }

  def subscribed?
    Time.current < expiry_date
  end
end
