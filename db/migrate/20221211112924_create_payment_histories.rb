class CreatePaymentHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :amount, precision: 18, scale: 0
      t.integer :money_kind, default: 0
      t.timestamps
    end
  end
end
