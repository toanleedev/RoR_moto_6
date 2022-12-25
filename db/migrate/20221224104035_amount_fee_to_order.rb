class AmountFeeToOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :amount_include_fee, :decimal, precision: 18, scale: 0
    add_column :orders, :service_fee, :decimal, precision: 18, scale: 0
  end
end
