class CreatePartnerHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :partner_histories do |t|
      t.string :full_name
      t.string :phone
      t.string :email
      t.string :address
      t.string :title
      t.string :description
      t.string :tax_code
      t.integer :user_kind, default: 0
      t.integer :status, default: 0
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
