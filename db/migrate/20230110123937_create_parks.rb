class CreateParks < ActiveRecord::Migration[6.1]
  def change
    create_table :parks do |t|
      t.integer :user_id,null: false
      t.integer :prefecture_id
      t.string :park,null: false
      t.string :address,null: false
      t.float :longitude
      t.float :latitude
      t.text :detail
      t.boolean :status, null: false, default: "true"
      t.timestamps
    end
  end
end
