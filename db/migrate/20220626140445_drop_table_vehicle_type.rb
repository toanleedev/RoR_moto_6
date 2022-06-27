class DropTableVehicleType < ActiveRecord::Migration[6.0]
  def change
    drop_table :vehicle_types
    drop_table :vehicle_brands
  end
end
