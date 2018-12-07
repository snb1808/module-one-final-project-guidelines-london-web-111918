require "terminal-table"
require "table_print"
require 'highline'
require 'pry'

require_relative "./search_and_save"

def welcome
  puts "\n \n"
  puts "    Welcome to your CRM tool! Please enter your username."
  puts "\n \n"
  name = gets.chomp
  name
end

def username_search
  if User.all.find {|user| user.username == USERNAME}
    puts "\n \n"
    puts "    Welcome back, #{USERNAME}!"
  else
    user = User.new(username: USERNAME)
    user.save
    puts "\n \n"
    puts "    New user created. Nice to meet you, #{USERNAME}!"
 end
end

def run_main_menu(counter = 0)
  choice = options(counter).to_i
  case choice
    when 1
      run_option_1
    when 2
      run_option_2
    when 3
      run_option_3
    else
      puts "\n \n"
      puts "    Please choose a number between 1 and 3"
  end
end

def options(counter)
  puts "\n \n"
  puts "    Please select one of the following options:"
  if counter == 0
    puts "       1. Search businesses by category and location"
  else
    puts "       1. Make another search"
  end
  puts "       2. Contact History"
  puts "       3. Exit application"
  puts "\n \n"
  input = gets.chomp
  input
end


# ------------------------- Option 1 --------------------------

def run_option_1
  results = user_input
  counter = display_table(results)
  run_main_menu(counter)
  # save_table_or_options_menu?
end

def user_input
  puts "\n \n"
  puts "    Please enter the category and location, separated by a comma.\n \n"
  search_result = gets.chomp
  array = search_result.split(",")
  yelp_results_hash(array)
end

def yelp_results_hash(array)
  result_hash = search(array[0], array[1]) # yelp api call
end

def display_table(yelp_results_hash)
  counter = 0
  rows = []
  yelp_results_hash["businesses"].each do |business|
    rows << [business["name"], business["location"]["display_address"], business["phone"], business["rating"], business["price"]]
    for_db = {name: business["name"], phone: business["phone"], location: business["location"]["display_address"], review_count: business["review_count"], rating: business["rating"], price: business["price"], website: business["url"]}
    Business.create(for_db)
  end
  table = Terminal::Table.new :headings => ["Name", "Address", "Phone", "Rating", "Price"], :rows => rows
  puts "\n \n"
  puts table
  puts "\n \n"
  counter += 1
  counter
end

# ------------------------- Option 2 --------------------------

def run_option_2
  display_contact_history_table(retrieve_current_user_details)
  display_contact_history_options
end

def retrieve_current_user_details
  current_user = User.find_by(username: "#{USERNAME}")
  current_user
end

def display_contact_history_table(contact_history_array)
  puts "\n \n"
  rows = []
  ContactHistory.all.each do |rec|
    business = Business.all.select {|biz| biz.id == rec.business_id}
    users = User.all.select {|user| user.id == rec.user_id}
    users.each do |user|
    business.each do |biz|
    rows << [rec.id, user.username, biz.name, biz.id, biz.phone, rec.status, rec.date, rec.description]
  end
end
  end
  table = Terminal::Table.new :headings => ["ID", "User", "Business", "Business ID", "Phone", "Status", "Date", "Description"], :rows => rows
  puts table
  puts "\n \n"
end

def display_contact_history_options
  cli = HighLine.new
  puts "\n \n"
  answer = cli.ask(
  "   Choose an option:
      1. Create a new record
      2. Update a record
      3. Delete a record
      4. Show all businesses
      5. Find a business by name
      6. Find all records for a business
      7. Find only my records
      8. Find a colleages records
      9. Find businesses not contacted since a given date
      10. Search by date
      11. Main menu\n \n", Integer) { |q| q.in = 1..11 }

  case answer
    when 1
      create_a_new_record
    when 2
      update_a_record
    when 3
      delete_a_record
    when 4
      display_all_businesses
    when 5
      find_business_by_name
    when 6
      find_all_records_for_a_business
    when 7
      find_only_my_records
    when 8
      find_a_colleages_records
    when 9
      find_a_business_not_contacted_since_a_given_date
    when 10
      search_by_date
    when 11
      run_main_menu
    else
      puts "    You must enter a valid option."
  end
end

def update_a_record
  cli = HighLine.new
  puts "\n \n"
  record_id = cli.ask("   Enter a record ID\n \n", Integer)
  puts "\n \n"
  rows = []
  records = ContactHistory.all.select {|rec| rec.id == record_id}
  records.each do |rec|
    business = Business.all.select {|biz| biz.id == rec.business_id}
    business.each do |biz|
      rows << [rec.id, biz.name, biz.phone, rec.status, rec.date, rec.description]
    end
  end
  table = Terminal::Table.new :headings => ["ID", "Name", "Phone", "Status", "Date", "Description"], :rows => rows
  puts table
  puts "\n \n"
  loop do answer_id = cli.ask(
    "   Choose an option
        1. Update status
        2. Update description
        3. Go back to display contact history options\n \n" , Integer) { |q| q.in = 1..3 }
  case answer_id
  when 1
    new_status = cli.ask("    Write a new status\n \n")
    ContactHistory.where(id: record_id).update(status: new_status)
    puts "\n \n"
    render_contact_histories_table(record_id)
    display_contact_history_options
  when 2
    new_description = cli.ask("   Write a new description")
    ContactHistory.where(id: record_id).update(description: new_description)
    puts "\n \n"
    render_contact_histories_table(record_id)
    display_contact_history_options
  when 3
    display_contact_history_options
  end
end
end

def render_contact_histories_table(record_id)
  rows = []
  rec = ContactHistory.find(record_id)
      rows << [rec.id, rec.status, rec.date, rec.description]
  table = Terminal::Table.new :headings => ["ID", "Status", "Date", "Description"], :rows => rows
  puts table
end

def create_a_new_record
  display_all_businesses
  new = ContactHistory.new
  new.user_id = retrieve_current_user_details.id
  new.date = DateTime.now
  puts "\n \n   Please enter the business ID\n \n"
  new.business_id = gets.chomp
  puts "\n \n   What is the status of this interaction?\n \n"
  new.status = gets.chomp
  puts "\n \n   Please enter a description for this interaction\n \n"
  new.description = gets.chomp
  puts "\n \n"
  new.save
  rows = []
  business = Business.all.find {|biz| biz.id == new.business_id}
  rows << [new.id, new.status, new.date, new.description, business.name]
  table = Terminal::Table.new :headings => ["ID", "Status", "Date", "Description", "Business"], :rows => rows
  puts table
end

def delete_a_record
  puts "\n \n   Enter the ID of the record you wish to delete\n \n"
  record_to_delete = ContactHistory.find_by(id: gets.chomp)
  if !record_to_delete
    puts "\n \n   This record does not exist. Returning to main menu."
  else
    rows = []
    rows << [record_to_delete.id, record_to_delete.status, record_to_delete.date, record_to_delete.description]
    table = Terminal::Table.new :headings => ["ID", "Status", "Date", "Description"], :rows => rows
    puts table
  puts "\n \n   Are you sure you wish to delete this record? Enter y/n\n \n"
  answer = gets.chomp
  case answer
  when "y"
    record_to_delete.destroy
    puts "\n \n   Record deleted. Returning to main menu."
  else
    puts "\n \n   Record not deleted. Returning to main menu."
  end
end
  sleep(1)
  run_main_menu
end

def display_all_businesses
  rows = []
  Business.all.each do |business|
      rows << [business.id, business.name, business.phone, business.location[1..-2], business.review_count, business.rating, business.price]
  end
  table = Terminal::Table.new :headings => ["ID", "Name", "Phone", "Location", "Review Count", "Rating", "Price"], :rows => rows
  puts table
end

def find_business_by_name
  puts "\n \n   Please enter the business' name\n \n"
  answer = gets.chomp
  puts "\n \n"
  business = Business.all.select {|biz| biz.name == answer}
  rows = []
  business.each do |biz|
  records = ContactHistory.all.select {|rec| rec.business_id == biz.id}
  records.each do |rec|
      rows << [biz.id, biz.name, biz.phone, biz.location, biz.website.split("?")[0], rec.id, rec.status, rec.description]
    end
  end
  table = Terminal::Table.new :headings => ["ID", "Name", "Phone", "Location", "Website", "Record ID", "Status", "Description"], :rows => rows
  puts table
end

def find_all_records_for_a_business
  puts "\n \n   Please enter the business ID\n \n"
  answer = gets.chomp.to_i
  puts "\n \n"
  all_rows = ContactHistory.all.select {|rec| rec.business_id == answer}
  tp all_rows, :id,
              {:business_id => {:display_name => "business ID"}},
              {:user_id => {:display_name => "user ID"}},
              :status,
              {:description => {:width => 100}},
              :date
end

def find_only_my_records
  userid = retrieve_current_user_details.id
  tp ContactHistory.where(user_id: userid), :id, {:status => {:display_name => "Status", :width => 12}}, {:updated_at => {:display_name => "Contact Date", :width => 20}}, {:description => {:display_name => "Description", :width => 100}}
end

def find_a_colleages_records
  tp User.all, :id, :username
  puts "\n \n   Enter user ID\n \n"
  answer = gets.chomp
  puts "\n \n"
  tp ContactHistory.where(user_id: answer),
          :id,
          {:status => {:display_name => "Status", :width => 20}},
          {:updated_at => {:display_name => "Contact Date", :width => 20}},
          {:description => {:display_name => "Description", :width => 100}},
          {"business.name" => {:display_name => "Business"}}
end

def find_a_business_not_contacted_since_a_given_date
  puts "\n \n   Enter the date in the following format: YYYY-MM-DD\n \n"
  date = gets.chomp
  puts "\n \n"
  tp ContactHistory.where("updated_at >= ?", date),
  :id,
  {"user.id" => {:display_name => "User ID"}},
  {:status => {:display_name => "Status", :width => 20}},
  {:updated_at => {:display_name => "Contact Date", :width => 20}},
  {:description => {:display_name => "Description", :width => 100}},
  {"business.name" => {:display_name => "Business"}},
  {"user.username" => {:display_name => "User"}}
end

def filter_by_status
end

def search_by_date
  puts "\n \n    Enter the date of the interation in the following format: YYYY-MM-DD\n \n"
  date = gets.chomp
  datetime = :updated_at
  date2 = datetime[0].split(" ")[0]
  tp ContactHistory.where(date2 == date),
        :id,
        {"user.id" => {:display_name => "User ID"}},
        {:status => {:display_name => "Status", :width => 20}},
        {:updated_at => {:display_name => "Contact Date", :width => 20}},
        {:description => {:display_name => "Description", :width => 100}},
        {"business.name" => {:display_name => "Business"}}
end

#-------------------- Option 3 --------------------------

def run_option_3
  end_message
  sleep(1)
  exit
end

def end_message
  puts "\n \n"
  puts "    Thank you for using the CRM app, #{USERNAME}! Have a nice day!"
  puts "\n \n"
end
