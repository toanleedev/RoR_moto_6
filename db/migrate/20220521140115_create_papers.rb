class CreatePapers < ActiveRecord::Migration[6.0]
  def change
    create_table :papers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :card_number
      t.text :card_front_url
      t.text :card_back_url
      t.string :driver_number
      t.text :driver_front_url
      t.text :driver_back_url
      t.boolean :is_verified, default: false
      t.datetime :verified_at

      t.timestamps
    end
  end
end
