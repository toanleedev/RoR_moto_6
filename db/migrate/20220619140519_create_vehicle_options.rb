class CreateVehicleOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicle_options do |t|
      t.string :key
      t.string :name_vi
      t.string :name_en
    end
  end
end
