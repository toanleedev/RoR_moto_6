module Account
  module AddressesHelper
    def default_address(vehicle)
      current_user.address_default_id == vehicle.id
    end
  end
end
