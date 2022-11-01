class CheckoutController < ApplicationController
  before_action :set_vehicle, except: %i[confirmation]
  before_action :authenticate_user!
  before_action :validate_before_order, only: [:confirm]

  def confirm
    # check params lai cho nay
    @vehicle_params = params
    @order = Order.new
    render 'confirm', locals: { vehicle: @vehicle }, collection: @order
  end

  def complete
    redirect_to root_path unless params[:uid].present?
  end

  def confirmation
    order = Order.find_by(uid: params[:uid])

    if order.present?
      return redirect_to root_path, flash: { alert: 'Đơn đã được xác nhận.' } if order.status == 'pending'

      order.status = :pending
      order.confirmed_at = Time.current

      if order.save
        flash[:notice] = 'Xác nhận đơn thành công'
      else
        flash[:alert] = 'Xác nhận đơn thất bại'
      end
    else
      flash[:alert] = 'Không tìm thấy uid'
    end
    redirect_to root_path
  end

  def payment
    environment = PayPal::SandboxEnvironment.new(ENV.fetch('PAYPAL_CLIENT_ID'),
                                                 ENV.fetch('PAYPAL_SECRET'))
    client = PayPal::PayPalHttpClient.new(environment)
    request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest.new(params[:payment_id])
    order = Order.find_by(uid: params[:order_uid])

    return redirect_to account_orders_path, flash: { alert: t('.order_not_found') } if order.blank?

    begin
      response = client.execute(request).result

      if response.status == 'COMPLETED'
        order.paid_at = Time.current
        order.payment_security = response.id
        order.payment_info = response.status
        order.save!
        render json: { message: 'Thanh toan thanh cong',
                       url: account_order_path(order) }, status: :ok
      end
    rescue PayPalHttp::HttpError => e
      # Something went wrong server-side
      puts e.status_code
      puts e.headers['debug_id']
      render json: { message: 'Thanh toan that bai' }, status: :bad_request
    end
  end

  private

  def set_vehicle
    @vehicle = Vehicle.includes(:brand, :type, :engine, :user)
                      .find_by(id: params[:vehicle_id])
  end

  def validate_before_order
    unless current_user.paper&.confirmed?
      return redirect_to account_paper_path, flash: { alert: t('.require_paper') }
    end

    return unless current_user.orders.already_order.any?

    redirect_to request.referrer, flash: { alert: t('.already_order') }
  end
end
