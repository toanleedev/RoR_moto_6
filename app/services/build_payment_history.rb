class BuildPaymentHistory
  def initialize(params, options = {})
    @params = params
  end

  attr_reader :params, :current_user

  def save
    ActiveRecord::Base.transaction do
      payment_history = PaymentHistory.new params
      payment_history.save!
    end
  rescue StandardError => e
    ServiceResult.new(success: false, errors: [e])
  end
end
