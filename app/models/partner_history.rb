# == Schema Information
#
# Table name: partner_histories
#
#  id          :bigint           not null, primary key
#  full_name   :string
#  phone       :string
#  email       :string
#  address     :string
#  title       :string
#  description :string
#  tax_code    :string
#  user_kind   :integer          default(NULL)
#  status      :integer          default("pending")
#  user_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class PartnerHistory < ActiveRecord::Base
  belongs_to :user
  enum user_kind: {
    personal: 1,
    company: 2
  }
  enum status: {
    pending: 0,
    confirmed: 1,
    canceled: 2
  }

  def pending?
    status == 'pending'
  end

  def canceled?
    status == 'canceled'
  end

  def confirmed?
    status == 'confirmed'
  end
end
