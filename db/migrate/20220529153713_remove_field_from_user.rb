class RemoveFieldFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :activation_digest, :string
    remove_column :users, :is_activated, :boolean
    remove_column :users, :is_block, :boolean
    remove_column :users, :activated_at, :datetime
    remove_column :users, :remember_digest, :string
  end
end
