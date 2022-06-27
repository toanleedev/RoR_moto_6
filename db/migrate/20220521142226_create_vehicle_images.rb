class CreateVehicleImages < ActiveRecord::Migration[6.0]
  def change
    create_table(:vehicle_images) do |t|
      t.references(:vehicle, null: false, foreign_key: true)
      t.text(:image_path)
      t.timestamps
    end
  end
end
