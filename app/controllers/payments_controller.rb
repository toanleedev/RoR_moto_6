class PaymentsController < ApplicationController
  before_action :set_vehicle, only: %i[priority]

  attr_reader :vehicle

  def priority
    environment = PayPal::SandboxEnvironment.new(
      ENV.fetch('PAYPAL_CLIENT_ID'), ENV.fetch('PAYPAL_SECRET'))
    client = PayPal::PayPalHttpClient.new(environment)
    request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest.new(params[:payment_id])
    priority = Priority.find_by(id: params[:priority_id])

    if priority.blank?
      redirect_to account_vehicle_path(vehicle), flash:
        { alert: t('.priority_not_found') }
    end

    begin
      response = client.execute(request).result

      if response.status == 'COMPLETED'
        priority.status = :online
        Payment.create paymentable: priority, user_id: current_user.id,
                       payment_kind: :bank_transfer, payment_security: response.id,
                       amount: priority.amount, paid_at: Time.current, status: :completed

        priority.save!
        render json: { message: t('message.success.payment'),
                       url: account_vehicle_path(vehicle) }, status: :ok
      end
    rescue PayPalHttp::HttpError => e
      # Something went wrong server-side
      puts e.status_code
      puts e.headers['debug_id']
      render json: { message: t('.message.failure.payment') }, status: :bad_request
    end
  end

  private

  def set_vehicle
    binding.pry
    @vehicle = Vehicle.includes(:brand, :type, :engine, :user, :priorities)
                      .find_by(id: params[:id])

    return unless @vehicle.blank?

    flash[:alert] = '.vehicle_not_found'
    redirect_to request.referrer
  end
end
