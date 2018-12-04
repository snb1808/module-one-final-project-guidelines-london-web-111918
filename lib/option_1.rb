def option_1
  puts "Please enter the category and location, separated by a comma."
  gets.chomp
end

def break_answer(string)
  array = string.split(",")
  array
end

def run_option_1
  search = option_1
  array = break_answer(option_1)
  search_and_add_businesses(array[0], array[1])
end
