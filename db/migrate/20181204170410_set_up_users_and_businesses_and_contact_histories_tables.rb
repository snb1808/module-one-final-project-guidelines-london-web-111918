class SetUpUsersAndBusinessesAndContactHistoriesTables < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
    end

    create_table :businesses do |t|
      t.string :name
      t.string :website
      t.integer :review_count
      t.integer :rating
      t.string :price
      t.string :location
      t.string :phone
    end

    create_table :contact_histories do |t|
      t.integer :user_id
      t.integer :business_id
      t.string :status
      t.string :description
      t.datetime :date
    end
  end
end
