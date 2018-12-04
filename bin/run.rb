require_relative '../config/environment'

username = welcome

def username_search(input)
  if !User.all.find {|user| user.username == input}
   User.new(username: input)
 else
   @username = input
 end

choice = options

until choice < 4 || choice > 0
  choice = options
end

case choice
when 1
  run_option_1
when 2
  run_option_2
when 3
  run_option_3
end

end_message
