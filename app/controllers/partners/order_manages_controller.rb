module Partners
  class OrderManagesController < ::OrdersController
    before_action :authenticate_user!
    before_action :set_order, except: %i[index create]
    layout 'partner'

    def index
      @orders = OrdersFilter.new(params, current_user).filter_rental
      @is_manage_page = true
    end

    def show; end

    attr_reader :order

    def cancel
      order.status = :canceled
      order.vehicle.status = :idle
      save_order order
      SendNotification.new(order).order_cancel
    end

    def accept
      order.status = :accepted
      save_order order
      SendNotification.new(order).order_accept unless params[:send_notify].present?
    end

    def processing
      order.status = :processing
      order.processing_at = Time.current
      save_order order
    end

    def completed
      service_fee = params[:amount].to_f * 0.05
      amount_include_fee = params[:amount].to_f - service_fee

      order.rental_times = params[:rental_times]
      order.amount = params[:amount]
      order.status = :completed
      order.vehicle.status = :idle
      order.completed_at = params[:completed_at]
      order.service_fee = service_fee
      order.amount_include_fee = amount_include_fee

      save_order order
    end

    def pending
      order.status = :pending
      save_order order
    end

    def checkout; end

    def cash_paid
      order.payment.paid_at = Time.current
      order.payment.status = :completed
      order.owner.partner.balance -= order.service_fee
      BuildPaymentHistory.new(payment_history_params).save
      save_order order
    end

    private

    def set_order
      @order = current_user.order_manages.includes(:vehicle).find_by(id: params[:id])

      return unless @order.blank?

      flash[:alert] = t('.order_not_found')
      redirect_to partners_order_manages_path
    end

    def save_order(order)
      if order.save
        flash[:notice] = t('message.success.update')
        redirect_to partners_order_manage_path(order)
      else
        flash[:alert] = t('message.failure.update')
        redirect_to request.referrer
      end
    end

    def payment_history_params
      {
        userable: order.owner.partner,
        money_kind: :expense,
        action_kind: :service_fee,
        amount: order.service_fee
      }
    end
  end
end
