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
      vehicle.status = :accepted
      if vehicle.save
        redirect_to admin_vehicle_path(vehicle), notice: t('.accepted_success')
      else
        redirect_to request.referrer, alert: t('.accepted_failure')
      end
    end

    def bulk_accepted
      Vehicle.where(id: params[:ids], status: :opening).update_all(status: :accepted)
    end

    def locked
      vehicle.status = :locked
      if vehicle.save
        redirect_to admin_vehicle_path(vehicle), notice: t('.locked_success')
      else
        redirect_to request.referrer, alert: t('.locked_failure')
      end
    end

    private

    def set_vehicle
      @vehicle = Vehicle.find_by(id: params[:id])

      return if @vehicle.present?
    end
  end
end
