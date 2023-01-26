class RemovePaymentFromOrder < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :payment_kind, :integer
    remove_column :orders, :payment_info, :string
    remove_column :orders, :payment_security, :string
    remove_column :orders, :message, :string
    remove_column :orders, :paid_at, :datetime
  end
end
