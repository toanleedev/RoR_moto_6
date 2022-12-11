class CreatePartners < ActiveRecord::Migration[6.0]
  def change
    create_table :partners do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :phone
      t.string :email
      t.string :address
      t.string :title
      t.string :description
      t.string :tax_code
      t.decimal :balance, precision: 18, scale: 0, default: 0
      t.integer :user_kind, default: 0
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
