class AddStatusToVehicle < ActiveRecord::Migration[6.0]
  def change
    add_column :vehicles, :status, :integer, default: 0
    remove_column :vehicles, :year_produce, :datetime
    add_column :vehicles, :year_produce, :integer
  end
end
