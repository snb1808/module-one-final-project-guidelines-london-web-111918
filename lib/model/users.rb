class User < ActiveRecord::Base
  has_many :contact_histories
  has_many :businesses, through: :contact_histories

  def initialize(username:)
    @username = username
  end

end
