class Createbusinesses < ActiveRecord::Migration[5.0]
  def change
    create_table :businesses do |t|
  t.string :name
  t.string :website
  t.integer :review_count
  t.integer :rating
  t.string :price
  t.string :location
  t.string :phone
end
  end
end
