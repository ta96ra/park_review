class RemoveDetailsFromParks < ActiveRecord::Migration[6.1]
  def change
    remove_column :parks, :details, :text
  end
end
