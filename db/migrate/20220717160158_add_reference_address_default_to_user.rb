class AddReferenceAddressDefaultToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :address_default, foreign_key: { to_table: :addresses }
  end
end
