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
        Payment.create paymentable: priority, user_id: current_user.id,
                       payment_kind: :bank_transfer, payment_security: response.id,
                       amount: priority.amount, paid_at: Time.current, status: :completed

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
end
