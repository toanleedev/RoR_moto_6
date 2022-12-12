module Admin
  class VehiclesController < AdminController
    before_action :set_vehicle, except: %i[index]
    def index
      @vehicles = Vehicle.order('vehicles.created_at DESC').all

      respond_to do |format|
        format.html
        format.json { render json: @vehicles }
      end
    end

    def show; end

    attr_reader :vehicle

    def accepted
      vehicle.status = :idle
      if vehicle.save
        send_accepted_message
        redirect_to admin_vehicle_path(vehicle), notice: t('.accepted_success')
      else
        redirect_to request.referrer, alert: t('.accepted_failure')
      end
    end

    def bulk_accepted
      Vehicle.where(id: params[:ids], status: :opening).update_all(status: :accepted)
    end

    def update
      vehicle.status = params[:status]
      if vehicle.save
        flash[:notice] = t('message.success.update')
      else
        flash[:alert] = t('message.failure.update')
      end
      redirect_to admin_vehicle_path(vehicle)
    end

    private

    def set_vehicle
      @vehicle = Vehicle.find_by(id: params[:id])

      return if @vehicle.present?
    end

    def send_accepted_message
      message = {
        sender_id: current_user.id,
        receiver_id: vehicle.user_id,
        on_click_url: "partners/vehicles/#{vehicle.id}",
        title: 'notification.title.vehicle_accepted',
        content: 'notification.content.vehicle_accepted'
      }
      SendNotification.new(message).call
    end
  end
end
