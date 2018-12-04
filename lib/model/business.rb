class Business < ActiveRecord::Base
  has_many :contact_history
  has_many :users, through: :contact_history
end
