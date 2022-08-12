class SearchesController < ApplicationController
  before_action :set_options, only: %i[index edit]

  def index
    @vehicles = SearchFilter.new(params).filter
    @time_now = Time.new.strftime('%Y-%m-%dT%k:%M')
  end

  private

  def set_options
    @vehicle_brands = VehicleOption.brands.pluck(:name_vi, :id)
    @vehicle_types = VehicleOption.types.pluck(:name_vi, :id)
    @vehicle_engines = VehicleOption.engines.pluck(:name_vi, :id)
  end
end
