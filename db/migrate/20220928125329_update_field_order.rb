class UpdateFieldOrder < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :confirmed_at, :datetime
    add_column :orders, :processing_at, :datetime
    add_column :orders, :completed_at, :datetime
    add_column :orders, :paid_at, :datetime
    add_column :orders, :uid, :string
    remove_column :orders, :payment, :string, null: false, default: 'cash'
    add_column :orders, :payment, :integer, null: false, default: 0

    remove_column :orders, :is_paid, :boolean
    remove_column :orders, :is_confirmed, :boolean
  end
end
