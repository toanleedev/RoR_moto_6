module Admin
  class VehicleOptionsController < ApplicationController
    layout 'admin'
    before_action :set_vehicle_option, only: %i[edit update destroy]

    attr_reader :vehicle_option

    def index
      @vehicle_options = VehicleOption.all

      respond_to do |format|
        format.html
        format.json { render json: @vehicle_options }
      end
    end

    def new
      @vehicle_option = VehicleOption.new
    end

    def create
      @vehicle_option = VehicleOption.new vehicle_option_params

      if @vehicle_option.save
        flash[:notice] = t('message.success.create')
        redirect_to admin_vehicle_options_path
      else
        flash[:alert] = t('message.failure.create')
        render :new
      end
    end

    def edit; end

    def update
      if @vehicle_option.update vehicle_option_params
        flash[:notice] = t('message.success.update')
        redirect_to admin_vehicle_options_path
      else
        flash[:alert] = t('message.failure.update')
        render :edit
      end
    end

    def destroy
      if vehicle_option.destroy
        flash[:notice] = t('message.success.destroy')
      else
        flash[:alert] = t('message.failure.destroy')
      end
      redirect_to admin_vehicle_options_path
    rescue StandardError => e
      flash[:alert] = t('message.failure.destroy')
      redirect_to request.referrer
    end

    private

    def vehicle_option_params
      params.require(:vehicle_option).permit(:name_vi, :name_en, :key)
    end

    def set_vehicle_option
      @vehicle_option = VehicleOption.find_by(id: params[:id])
    end
  end
end
