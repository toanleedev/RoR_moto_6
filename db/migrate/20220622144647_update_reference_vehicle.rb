class UpdateReferenceVehicle < ActiveRecord::Migration[6.0]
  def change
    remove_reference :vehicles, :vehicle_option, foreign_key: true
    add_reference :vehicles, :brand, foreign_key: { to_table: :vehicle_options }
    add_reference :vehicles, :type, foreign_key: { to_table: :vehicle_options }
    add_reference :vehicles, :engine, foreign_key: { to_table: :vehicle_options }
    add_column :vehicles, :year_produce, :datetime
    remove_column :vehicles, :energy_number
  end
end
