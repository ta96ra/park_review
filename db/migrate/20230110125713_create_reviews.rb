class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :user_id,null: false
      t.integer :park_id,null: false
      t.text :review,null: false
      t.float :evaluation
      t.timestamps
    end
  end
end
