module Account
  class VehiclesController < ApplicationController
    layout 'account'
    before_action :authenticate_user!
    before_action :set_vehicle, except: %i[index new create destroy_image]
    before_action :set_options, only: %i[new edit]

    def index
      @vehicles = current_user.vehicles.includes(:brand, :type, :engine)
                              .order(created_at: :desc)
    end

    attr_reader :vehicle

    def new
      @vehicle = Vehicle.new
    end

    def show; end

    def create
      @vehicle = current_user.vehicles.new vehicle_params

      if @vehicle.save
        upload_image
        flash[:notice] = t('message.success.create')
        redirect_to edit_account_vehicle_path(@vehicle)
      else
        set_options
        flash[:alert] = t('message.failure.create')
        render 'new'
      end
    end

    def edit; end

    def update
      if @vehicle.update vehicle_params
        upload_image
        flash[:notice] = t('message.success.update')
        redirect_to edit_account_vehicle_path(@vehicle)
      else
        flash[:alert] = t('message.failure.update')
        render :edit
      end
    end

    def destroy
      if @vehicle.destroy
        flash[:notice] = t('message.success.destroy')
        redirect_to account_vehicles_path
      else
        flash[:alert] = t('message.failure.destroy')
        render :edit
      end
    end

    def destroy_image
      vehicle = Vehicle.find_by(id: params[:vehicle_id])
      image = vehicle.vehicle_images.find_by(id: params[:id])
      if image.image_path.file.exists?
        image.image_path.file.delete
        image.destroy
        flash[:notice] = t('message.success.destroy')
      else
        flash[:alert] = t('message.failure.destroy')
      end
      redirect_to request.referrer
    end

    def update_status
      return unless params[:status].present?

      vehicle.status = params[:status]
      if vehicle.save
        flash[:notice] = t('message.success.update')
      else
        flash[:alert] = t('message.failure.update')
      end
      redirect_to edit_account_vehicle_path(@vehicle)
    end

    def priority
      @priority = vehicle.priorities.new unless vehicle.lastest_subscribe_priority.present?
      @rank_options = [
        [t('.silver_package'), 'silver'],
        [t('.gold_package'), 'gold'],
        [t('.diamon_package'), 'diamon']
      ]
      @duration_options = [
        [t('.duration_month', month: 1), 1],
        [t('.duration_month', month: 2), 2],
        [t('.duration_month', month: 3), 3],
        [t('.duration_month', month: 6), 6],
        [t('.duration_month', month: 12), 12],
      ]
    end

    def priority_create
      priority = vehicle.priorities.new priority_params
      priority.expiry_date = Time.current + priority.duration.month

      if priority.save
        flash[:notice] = t('message.success.create')
      else
        flash[:alert] = t('message.failure.create')
      end
      redirect_to priority_account_vehicle_path(vehicle)
    end

    def priority_payment
      environment = PayPal::SandboxEnvironment.new(
        ENV.fetch('PAYPAL_CLIENT_ID'), ENV.fetch('PAYPAL_SECRET'))
      client = PayPal::PayPalHttpClient.new(environment)
      request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest.new(params[:payment_id])
      priority = Priority.find_by(id: params[:priority_id])

      if priority.blank?
        redirect_to priority_account_vehicle_path(vehicle), flash:
          { alert: t('.priority_not_found') }
      end

      begin
        response = client.execute(request).result

        if response.status == 'COMPLETED'
          priority.paid_at = Time.current
          priority.status = :online

          priority.save!
          render json: { message: t('message.success.payment'),
                         url: priority_account_vehicle_path(vehicle) }, status: :ok
        end
      rescue PayPalHttp::HttpError => e
        # Something went wrong server-side
        puts e.status_code
        puts e.headers['debug_id']
        render json: { message: t('.message.failure.payment') }, status: :bad_request
      end
    end

    private

    def vehicle_params
      params.require(:vehicle).permit :name, :description, :price, :year_produce,
                                      :brand_id, :type_id, :engine_id,
                                      images_attributes: %i[id vehicle_id image_path]
    end

    def priority_params
      params.require(:priority).permit :rank, :duration, :amount, :expiry_date
    end

    def upload_image
      return unless params[:images].present?

      params[:images]['image_path'].each do |image|
        @image = @vehicle.vehicle_images.create!(image_path: image)
      end
    end

    def set_vehicle
      @vehicle = Vehicle.includes(:brand, :type, :engine, :user, :priorities)
                        .find_by(id: params[:id])

      return unless @vehicle.blank?

      flash[:alert] = '.vehicle_not_found'
      redirect_to request.referrer
    end

    def set_options
      @vehicle_brands = VehicleOption.brands.pluck(:name_vi, :id)
      @vehicle_types = VehicleOption.types.pluck(:name_vi, :id)
      @vehicle_engines = VehicleOption.engines.pluck(:name_vi, :id)
    end
  end
end
