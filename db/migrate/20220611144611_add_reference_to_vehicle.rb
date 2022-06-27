class AddReferenceToVehicle < ActiveRecord::Migration[6.0]
  def change
    add_reference :vehicles, :vehicle_brand, foreign_key: true
    add_reference :vehicles, :vehicle_type, foreign_key: true
  end
end
