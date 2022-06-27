class UpdateFieldVehicle < ActiveRecord::Migration[6.0]
  def change
    remove_column :vehicles, :title
    remove_column :vehicles, :brand
    remove_column :vehicles, :type
    remove_column :vehicles, :status
    add_column :vehicles, :energy_number, :integer
  end
end
