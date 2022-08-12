class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :count_rental_days
      t.decimal :amount, precision: 18, scale: 0
      t.string :message
      t.integer :status, default: 0
      t.string :confirmation_token
      t.boolean :is_confirmed, default: false
      t.boolean :is_home_delivery, default: false
      t.string :delivery_address
      t.boolean :is_prepaid, default: false
      t.decimal :prepaid_discount, precision: 18, scale: 0
      t.string :payment, null: false, default: 'cash'
      t.string :payment_info
      t.boolean :is_paid, default: false
      t.decimal :discount, precision: 18, scale: 0
      t.references :vehicle, null: false, foreign_key: true
      t.references :renter, foreign_key: { to_table: :users }
      t.references :owner, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
