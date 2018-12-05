require "terminal-table"
require "table_print"
require_relative "./search_and_save"

def welcome
  puts "\n \n"
  puts "Welcome to your CRM tool! Please enter your username."
  gets.chomp
end

def username_search(input)
  if User.all.find {|user| user.username == input}
    puts "\n \n"
    puts "Welcome back, #{input}!"
  else
    user = User.new(username: input)
    user.save
    puts "\n \n"
    puts "New user created. Nice to meet you, #{input}!"
 end
end

def options
  puts "\n \n"
  puts "Please select one of the below options:"
  puts "1. Search businesses by category and location"
  puts "2. Contact History"
  input = gets.chomp
  input
end

def end_message
  puts "\n \n"
  puts "Thank you for using the CRM app! Have a nice day!"
end


# ------------------------- Option 1 --------------------------

def run_option_1
  results = user_input
  display_table(results)
  # save_table_or_options_menu?
end


def user_input
  puts "\n \n"
  puts "Please enter the category and location, separated by a comma."
  search_result = gets.chomp
  array = search_result.split(",")
  yelp_results_hash(array)
end

def yelp_results_hash(array)
  result_hash = search(array[0], array[1]) # yelp api call
end

def display_table(yelp_results_hash)
  rows = []
  rows << ["Name", "Address", "Phone", "Rating", "Price"]
  yelp_results_hash["businesses"].each do |business|
    rows << [business["name"], business["location"]["display_address"], business["phone"], business["rating"], business["price"]]
    for_db = {name: business["name"], phone: business["phone"], location: business["location"]["display_address"], review_count: business["review_count"], rating: business["rating"], price: business["price"], website: business["url"]}
    Business.create(for_db)
  end
  table = Terminal::Table.new :rows => rows
  puts "\n \n"
  puts table
  puts "\n \n"
end

# def save_table_or_options_menu?
#   puts "[s] to save table to database"
#   puts "[o] to go back to options menu "
#   answer = gets.chomp
#   if answer == "s"
#      save_table_to_db
#   elsif answer == "o"
#     options
#   else
#     nil
#   end
# end


# ------------------------- Option 2 --------------------------

def run_option_2(username)
  display_contact_history_table(retrieve_current_contact_history(username))
  display_contact_history_options
end

def retrieve_current_contact_history(username)
  username = username
  current_user = User.find_by(username: "#{username}")
  current_contact_ledger = []
  current_contact_ledger << ContactHistory.where(user_id: current_user)
  # binding.pry
end

def display_contact_history_table(contact_history_array)
  puts "\n \n"
  tp Business.all, :id, {:name => {:width => 70}}, :phone, {"contact_histories.status" => {:display_name => "Status", :width => 12}}, {"contact_histories.updated_at" => {:display_name => "Contact Date", :width => 20}}, {"contact_histories.description" => {:display_name => "Description", :width => 100}}
  puts "\n \n" 
end

def display_contact_history_options
  puts "\n \n"
  puts "Options"
  puts "1. Update a record"
  puts "2. Create a new record"
  puts "3. Find business by name"
  puts "4. Find only my records"
  puts "5. Find colleages records"
  puts "6. Find businesses not contacted before a given date"
  puts "7. Filter by status"
  puts "8. Search by date"
  puts "9. Search by data range"
  puts "10. Main Menu"
  puts "\n \n"
end
