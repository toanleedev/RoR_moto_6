class VehiclesController < ApplicationController
  def show
    @vehicle = Vehicle.includes(:brand, :type, :engine, :vehicle_images, user: [:address_default])
                      .find_by(id: params[:id])
  end
end
