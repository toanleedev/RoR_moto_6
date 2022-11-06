class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.integer :rate_kind, default: 0
      t.integer :rating_point
      t.text :content
      t.references :reviewer, foreign_key: { to_table: :users }
      t.references :order, null: false, foreign_key: true
    end
  end
end
