class RemoveManualDateColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :contact_histories do |t|
      t.datetime :date
    end
  end
end
