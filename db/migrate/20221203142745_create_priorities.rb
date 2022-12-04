class CreatePriorities < ActiveRecord::Migration[6.0]
  def change
    create_table :priorities do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.integer :rank, default: 0
      t.integer :duration
      t.decimal :amount, precision: 18, scale: 0
      t.datetime :paid_at
      t.datetime :expiry_date
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
