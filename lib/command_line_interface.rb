require "terminal-table"
require "table_print"
require 'highline'


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
  tp Business.all, :id, {:name => {:width => 70}}, :phone, {"contact_histories.id" => {:display_name => "Msg_ID", :width => 6}},{"contact_histories.status" => {:display_name => "Status", :width => 12}}, {"contact_histories.updated_at" => {:display_name => "Contact Date", :width => 20}}, {"contact_histories.description" => {:display_name => "Description", :width => 100}}
  puts "\n \n"
end

def display_contact_history_options
  cli = HighLine.new
  puts "\n \n"
  answer = cli.ask(
  "Choose an option
  1. Update a record
  2. Create a new record
  3. Find a business by name
  4. Find only my records
  5. Find a colleages records
  6. Find businesses not contacted before a given date
  7. Filter by status
  8. Search by date
  9. Search by data range
  10. Main Menu", Integer) { |q| q.in = 1..10 }
  puts "\n \n"

  case answer
    when 1
      update_a_record
    when 2
      create_a_new_record
    when 3
      find_a_business_by_name
    when 4
      find_only_my_records
    when 5
      find_a_colleages_records
    when 6
      find_a_business_not_contacted_before_a_given_date
    when 7
      filter_by_status
    when 8
      search_by_date
    when 9
      search_by_date_range
    when 10
      back_to_main_menu
    else
      puts "You must enter a valid Integer."
  end
end

def update_a_record
  cli = HighLine.new
  puts "\n \n"
  record_id = cli.ask("Enter a record ID", Integer)
  puts "\n \n"
  # binding.pry
  # display_contact_history_table(ContactHistory.find(record_id))
  tp ContactHistory.find(record_id), :id, {:status => {:display_name => "Status", :width => 12}}, {:updated_at => {:display_name => "Contact Date", :width => 20}}, {:description => {:display_name => "Description", :width => 100}}
  puts "\n \n"

  answer_id = cli.ask(
    "Choose an option
    1. Update status
    2. Update description
    3. Go back to display contact history options." , Integer) { |q| q.in = 1..3 }
  puts "\n \n"
end

def render_contact_histories_table(required_method)
  tp required_method, :id, {:status => {:display_name => "Status", :width => 12}}, {:updated_at => {:display_name => "Contact Date", :width => 20}}, {:description => {:display_name => "Description", :width => 100}}
end

def create_a_new_record
end

def find_a_business_by_name
end

def find_only_my_records
end

def find_a_colleages_records
end

def find_a_business_not_contacted_before_a_given_date
end

def filter_by_status
end

def search_by_date
end

def search_by_date_range
end

def back_to_main_menu
end
