require "terminal-table"

def option_1
  puts "Please enter the category and location, separated by a comma."
  gets.chomp
end

def break_answer(string)
  array = string.split(",")
  array
end

def run_option_1
  search_result = option_1
  array = break_answer(search_result)
  result_hash = search(array[0], array[1])
  rows = []
  rows << ["Name", "Address", "Rating", "Price"]
  result_hash["businesses"].each do |business|
  rows << [business["name"], business["location"]["display_address"], business["rating"], business["price"]]
  end
  table = Terminal::Table.new :rows => rows
end
