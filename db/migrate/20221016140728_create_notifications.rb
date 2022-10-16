class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :sender, foreign_key: { to_table: :users }
      t.references :receiver, foreign_key: { to_table: :users }
      t.string :title
      t.text :content
      t.string :on_click_url
      t.datetime :checked_at
      t.integer :type, default: 0

      t.timestamps
    end
  end
end
