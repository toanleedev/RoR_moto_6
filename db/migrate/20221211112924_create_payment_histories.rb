class CreatePaymentHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_histories do |t|
      t.references :userable, polymorphic: true
      t.references :payment, null: true, foreign_key: true
      t.integer :money_kind, default: 0
      t.integer :action_kind, default: 0
      t.decimal :amount, precision: 18, scale: 0
      t.timestamps
    end
  end
end
