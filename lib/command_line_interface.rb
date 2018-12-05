require "terminal-table"
require_relative "./search_and_save"

def welcome
  puts "Welcome to your CRM tool! Please enter your username."
  gets.chomp
end

def username_search(input)
  if User.all.find {|user| user.username == input}
    puts "Welcome back, #{input}!"
  else
    user = User.new(username: input)
    user.save
    puts "New user created. Nice to meet you, #{input}!"
 end
end

def options
  puts "Please select one of the below options:"
  puts "1. Search businesses by category and location"
  puts "2. View contact history"
  puts "3. Log a call"
  input = gets.chomp
  input
end

def end_message
  puts "Thank you for using the CRM app! Have a nice day!"
end


# ------------------------- Option 1 --------------------------

def run_option_1
  results = user_input
  display_table(results)
end


def user_input
  puts "Please enter the category and location, separated by a comma."
  search_result = gets.chomp
  array = search_result.split(",")
  yelp_results_hash(array)
end

def yelp_results_hash(array)
  result_hash = search(array[0], array[1]) # YELP API CALL
end

def display_table(yelp_results_hash)
  rows = []
  rows << ["Name", "Address", "Rating", "Price"]
  yelp_results_hash["businesses"].each do |business|
    rows << [business["name"], business["location"]["display_address"], business["rating"], business["price"]]
  end
  table = Terminal::Table.new :rows => rows
  puts table
end


# ------------------------- Option 2 --------------------------
