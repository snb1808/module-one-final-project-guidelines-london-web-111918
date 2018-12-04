class User < ActiveRecord::Base
  has_many :contact_history
  has_many :businesses, through: :contact_history

def initialize(username:)
  @username = username
end

end
