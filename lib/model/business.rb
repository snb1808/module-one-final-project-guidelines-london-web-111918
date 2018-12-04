class Business < ActiveRecord::Base
  has_many :contact_histories
  has_many :users, through: :contact_histories
end
