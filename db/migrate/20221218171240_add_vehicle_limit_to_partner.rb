class AddVehicleLimitToPartner < ActiveRecord::Migration[6.0]
  def change
    add_column :partners, :vehicle_limit, :integer, default: 2
  end
end
