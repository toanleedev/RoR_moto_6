class RemoveRatekindFromRating < ActiveRecord::Migration[6.0]
  def change
    remove_column :ratings, :rate_kind, :integer
  end
end
