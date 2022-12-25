class CheckoutController < ApplicationController
  before_action :set_vehicle, except: %i[confirmation payment_paypal complete]
  before_action :authenticate_user!
  before_action :validate_before_order, only: [:confirm]

  def confirm
    # check params lai cho nay
    @vehicle_params = params
    @order = Order.new
    @order.build_payment unless @order.build_payment.present?
    render 'confirm', locals: { vehicle: @vehicle }, collection: @order
  end

  def complete
    redirect_to root_path unless params[:uid].present?
  end

  def confirmation
    order = Order.find_by(uid: params[:uid])

    if order.present?
      return redirect_to root_path, flash: { alert: t('.order_confirmed') } if
        order.status == 'pending'

      order.status = :pending
      order.confirmed_at = Time.current

      if order.save
        flash[:notice] = t('.order_confirmed_success')
        return redirect_to account_order_path(order)
      else
        flash[:alert] = t('.order_confirmed_failure')
      end
    else
      flash[:alert] = t('.uid_not_found')
    end
    redirect_to root_path
  end

  def payment_paypal
    environment = PayPal::SandboxEnvironment.new(ENV.fetch('PAYPAL_CLIENT_ID'),
                                                 ENV.fetch('PAYPAL_SECRET'))
    client = PayPal::PayPalHttpClient.new(environment)
    request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest.new(params[:payment_id])
    order = Order.find_by(uid: params[:order_uid])

    return redirect_to account_orders_path, flash: { alert: t('.order_not_found') } if order.blank?

    begin
      response = client.execute(request).result

      if response.status == 'COMPLETED'
        order.payment.paid_at = Time.current
        order.payment.payment_security = response.id
        order.payment.status = :completed
        order.owner.partner.balance -= order.service_fee
        BuildPaymentHistory.new(order_payment_history_params(order)).save
        order.save!
        SendNotification.new(order).user_paid_order
        render json: { message: t('.pay_paypal_success'),
                       url: account_order_path(order) }, status: :ok
      end
    rescue PayPalHttp::HttpError => e
      # Something went wrong server-side
      puts e.status_code
      puts e.headers['debug_id']
      render json: { message: t('.pay_paypal_failure') }, status: :bad_request
    end
  end

  private

  def set_vehicle
    @vehicle = Vehicle.includes(:brand, :type, :engine, :user)
                      .find_by(id: params[:vehicle_id])

    return unless @vehicle.blank?

    flash[:alert] = t('.vehicle_not_found')
    redirect_to root_path
  end

  def validate_before_order
    unless current_user.paper&.confirmed?
      return redirect_to account_paper_path, flash: { alert: t('.require_paper') }
    end

    return unless current_user.orders.already_order.any?

    redirect_to request.referrer, flash: { alert: t('.already_order') }
  end

  def order_payment_history_params(order)
    {
      userable: order.owner.partner,
      money_kind: :expense,
      action_kind: :service_fee,
      amount: order.service_fee
    }
  end
end
