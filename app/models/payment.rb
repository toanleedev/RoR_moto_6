class Payment < ActiveRecord::Base
  belongs_to :paymentable, polymorphic: true

  enum payment_kind: {
    bank_transfer: 0
  }

  enum status: {
    pending: 0,
    completed: 1
  }
end
