def welcome
  puts "Welcome to your CRM tool! Please enter your username."
  gets.chomp
end

def username_search(input)
  if User.all.find {|user| user.username == input}
    user = User.new(username: input)
    user.save
    puts "New user created. Nice to meet you, #{input}!"
  else
    puts "Welcome back, #{input}!"
 end
end

def options
  puts "Please select one of the below options:"
  puts "1. Search businesses by category and location"
  puts "2. View contact history"
  puts "3. Log a call"
  get.chomp
end

def end_message
  puts "Thank you for using the CRM app! Have a nice day!"
end
