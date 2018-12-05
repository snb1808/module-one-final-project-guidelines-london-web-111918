class RemoveDateColumnAgain < ActiveRecord::Migration[5.2]
  def change
    remove_column :contact_histories, :date, :datetime
  end
end
