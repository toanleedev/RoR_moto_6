class AddFieldToPaper < ActiveRecord::Migration[6.0]
  def change
    add_column :papers, :is_card_verified, :boolean
    add_column :papers, :card_verified_at, :datetime
    add_column :papers, :is_driver_verified, :boolean
    add_column :papers, :driver_verified_at, :datetime
    add_column :papers, :other_license_url, :text
    remove_column :papers, :driver_back_url, :text
    remove_column :papers, :is_verified, :boolean
  end
end
