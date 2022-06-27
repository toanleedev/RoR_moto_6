class AddReferenceOptionToVehicle < ActiveRecord::Migration[6.0]
  def change
    add_reference :vehicles, :vehicle_option, foreign_key: true
  end
end
