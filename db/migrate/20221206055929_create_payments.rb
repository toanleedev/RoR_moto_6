class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.references :paymentable, polymorphic: true
      t.references :user, null: false, foreign_key: true
      t.integer :payment_kind
      t.string :payment_security
      t.decimal :amount, precision: 18, scale: 0
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
