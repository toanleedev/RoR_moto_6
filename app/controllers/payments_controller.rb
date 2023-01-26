class PaymentsController < ApplicationController
  def priority
    environment = PayPal::SandboxEnvironment.new(
      ENV.fetch('PAYPAL_CLIENT_ID'), ENV.fetch('PAYPAL_SECRET'))
    client = PayPal::PayPalHttpClient.new(environment)
    request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest.new(params[:payment_id])

    vehicle = Vehicle.find_by(id: params[:vehicle_id])
    return render json: { message: t('.vehicle_not_found'), status: 404 } unless vehicle.present?

    priority = vehicle.subscribe_priority
    return render json: { message: t('.priority_not_found'), status: 404 } unless priority.present?

    begin
      response = client.execute(request).result

      if response.status == 'COMPLETED'
        priority.status = :online
        payment = priority.payment
        payment.payment_security = response.id
        payment.paid_at = Time.current
        payment.status = :completed
        BuildPaymentHistory.new(payment_history_params(payment)).save
        priority.save!
        render json: { message: t('message.success.payment'),
                       url: partners_vehicle_path(vehicle) }, status: :ok
      end
    rescue PayPalHttp::HttpError => e
      # Something went wrong server-side
      puts e.status_code
      puts e.headers['debug_id']
      render json: { message: t('.message.failure.payment') }, status: :bad_request
    end
  end

  private

  def payment_history_params(payment)
    {
      payment_id: payment.id,
      userable: current_user.partner,
      money_kind: :expense,
      action_kind: :priority_fee,
      amount: payment.amount
    }
  end
end
