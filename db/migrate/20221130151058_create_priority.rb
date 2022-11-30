class CreatePriority < ActiveRecord::Migration[6.0]
  def change
    create_table :priorities do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.integer :rank
      t.datetime :expiry_date
      t.datetime :paid_at
      t.decimal :amount, precision: 18, scale: 0
      t.timestamps
    end
  end
end
