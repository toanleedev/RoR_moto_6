module Partners
  class PaymentHistoriesController < ApplicationController
    before_action :authenticate_user!
    layout 'partner'

    def show
      @payment_histories = current_user.partner.payment_histories.order(created_at: :desc)
      respond_to do |format|
        format.html
        format.json { render(json: @payment_histories) }
      end
    end
  end
end
