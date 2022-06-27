class AddNameToVehicle < ActiveRecord::Migration[6.0]
  def change
    add_column :vehicles, :name, :string
  end
end
