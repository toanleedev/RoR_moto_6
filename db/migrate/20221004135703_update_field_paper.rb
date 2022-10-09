class UpdateFieldPaper < ActiveRecord::Migration[6.0]
  def change
    remove_column :papers, :card_verified_at, :datetime
    remove_column :papers, :driver_verified_at, :datetime
    remove_column :papers, :other_license_url, :text
    remove_column :papers, :is_card_verified, :boolean
    remove_column :papers, :is_driver_verified, :boolean
    add_column :papers, :status, :integer, default: 0
  end
end
