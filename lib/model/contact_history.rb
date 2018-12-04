require 'date'

class ContactHistory < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :business

def initialize(user_id:, business_id:, status:, description:, date:)
  @user_id = user_id
  @business_id = business_id
  @status = "To call."
  @description = "Empty."
  @date = DateTime.now
end

end
