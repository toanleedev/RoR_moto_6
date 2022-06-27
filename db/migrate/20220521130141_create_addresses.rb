class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table(:addresses) do |t|
      t.references(:user, null: false, foreign_key: true)
      t.string(:province)
      t.string(:district)
      t.string(:ward)
      t.string(:street)
      t.text(:geocoding, array: true, default: [])

      t.timestamps
    end
  end
end
