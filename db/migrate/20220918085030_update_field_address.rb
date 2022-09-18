class UpdateFieldAddress < ActiveRecord::Migration[6.0]
  def change
    remove_column :addresses, :geocoding, :text
    remove_reference :users, :address_default, foreign_key: { to_table: :addresses }
  end
end
