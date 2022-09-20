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
end
