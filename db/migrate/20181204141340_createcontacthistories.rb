class Createcontacthistories < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_history do |t|
      t.integer :user_id
      t.integer :business_id
      t.string :status
      t.string :description
      t.datetime :date
    end
  end
end
