module Account
  module VehiclesHelper
    def vehicle_title(vehicle)
      "#{vehicle.brand.name_vi} #{vehicle.name}"
    end
  end
end
