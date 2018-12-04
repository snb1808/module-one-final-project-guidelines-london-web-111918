def welcome
  puts "Welcome your CRM tool! Please enter your username."
  gets.chomp
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
