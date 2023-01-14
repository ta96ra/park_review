class DropTableRating < ActiveRecord::Migration[6.1]
  def change
    drop_table 'rating_rates'
    drop_table 'rating_ratings'
  end
end
