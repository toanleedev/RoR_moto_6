class CreateMessage < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :sender, foreign_key: { to_table: :users }
      t.references :receiver, foreign_key: { to_table: :users }
      t.text :content
      t.datetime :checked_at
    end
  end
end
