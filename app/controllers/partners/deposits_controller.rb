module Partners
  class DepositsController < ApplicationController
    layout 'partner'

    def show
      @price_deposits = [5_000_000, 2_000_000, 1_000_000, 500_000, 100_000]
      @cache_price = Rails.cache.read 'deposit_price'
    end

    def create
      @price_deposit = params[:price]

      render 'checkout'
    end

    def checkout
      environment = PayPal::SandboxEnvironment.new(
        ENV.fetch('PAYPAL_CLIENT_ID'), ENV.fetch('PAYPAL_SECRET'))
      client = PayPal::PayPalHttpClient.new(environment)
      request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest.new(params[:payment_id])

      partner = current_user.partner
      return render json: { message: t('.partner_not_found'), status: 404 } unless partner.present?

      begin
        response = client.execute(request).result

        if response.status == 'COMPLETED'
          partner = current_user.partner
          partner.balance += params[:price_deposit]
          partner.save!
          # PaymentHistory.create
          render json: {
            message: t('message.success.payment'),
            url: partners_deposit_path
          }, status: :ok
        end
      rescue PayPalHttp::HttpError => e
        puts e.status_code
        puts e.headers['debug_id']
        render json: { message: t('.message.failure.payment') }, status: :bad_request
      end
    end
  end
end
