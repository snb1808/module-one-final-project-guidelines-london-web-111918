require 'date'

class ContactHistory < ActiveRecord::Base

  belongs_to :user
  belongs_to :business

# def initialize(user_id:, business_id:, status:, description:)
#   @user_id = user_id
#   @business_id = business_id
#   @status = status
#   @description = description
# end

end
