class Createusers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
        t.string :username
    end
  end
end
