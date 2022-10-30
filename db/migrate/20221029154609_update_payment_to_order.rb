class UpdatePaymentToOrder < ActiveRecord::Migration[6.0]
  def change
    rename_column :orders, :payment, :payment_kind
    add_column :orders, :payment_security, :string
  end
end
