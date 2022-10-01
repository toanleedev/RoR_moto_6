class CheckoutController < ApplicationController
  before_action :set_vehicle, except: %i[confirmation]
  before_action :authenticate_user!

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

  private

  def set_vehicle
    @vehicle = Vehicle.includes(:brand, :type, :engine, :user)
                      .find_by(id: params[:vehicle_id])
  end
end
