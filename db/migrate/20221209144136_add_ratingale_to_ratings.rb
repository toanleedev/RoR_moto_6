class AddRatingaleToRatings < ActiveRecord::Migration[6.0]
  def change
    add_reference :ratings, :ratingable, polymorphic: true, index: true
  end
end
