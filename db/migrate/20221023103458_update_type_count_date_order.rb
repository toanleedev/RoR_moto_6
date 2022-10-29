class UpdateTypeCountDateOrder < ActiveRecord::Migration[6.0]
  def change
    rename_column :orders, :count_rental_days, :rental_times
    change_column :orders, :rental_times, :float
    add_index :orders, :uid
  end
end
