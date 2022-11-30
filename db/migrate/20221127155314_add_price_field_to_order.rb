class AddPriceFieldToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :price, :decimal, precision: 18, scale: 0
    remove_column :orders, :is_prepaid, :boolean
    remove_column :orders, :prepaid_discount, :decimal, precision: 18, scale: 0
    remove_column :orders, :discount, :decimal, precision: 18, scale: 0
  end
end
