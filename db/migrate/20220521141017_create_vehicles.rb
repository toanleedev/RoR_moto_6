class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table(:vehicles) do |t|
      t.references(:user, null: false, foreign_key: true)
      t.string(:title)
      t.text(:description)
      t.string(:brand)
      t.string(:type)
      t.decimal(:price)
      t.integer(:status, comment: '0 1 2 4', default: 0)

      t.timestamps
    end
  end
end
