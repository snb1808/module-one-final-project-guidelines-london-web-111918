require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

u1 = User.new(username: "Jody123")
u2 = User.new(username: "Serena321")
u3 = User.new(username: "Patsy555")
u4 = User.new(username: "BobWazHere")
u5 = User.new(username: "MyspaceTom")

ch1 = ContactHistory.new(user_id: 1, business_id: 4)
ch2 = ContactHistory.new(user_id: 4, business_id: 2)
ch3 = ContactHistory.new(user_id: 2, business_id: 5)
ch4 = ContactHistory.new(user_id: 5, business_id: 5)
ch5 = ContactHistory.new(user_id: 1, business_id: 1)
ch6 = ContactHistory.new(user_id: 3, business_id: 3)
ch7 = ContactHistory.new(user_id: 2, business_id: 1)
