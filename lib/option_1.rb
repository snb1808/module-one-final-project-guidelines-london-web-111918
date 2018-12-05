# require "terminal-table"
#
# def run_option_1
#   user_input
#   yelp_results_hash
#   display_table
# end
#
# # def user_input
# #   array = break_answer(search_request)
# # end
#
# def user_input
#   puts "Please enter the category and location, separated by a comma."
#   search_result = gets.chomp
#   binding.pry
#   array = search_result.split(",")
#   array
# end
#
# # def break_answer(string)
# #   array = string.split(",")
# #   array
# # end
#
#
# def yelp_results_hash
#   result_hash = search(user_input[0], user_input[1])
# end
#
# def display_table
#   rows = []
#   rows << ["Name", "Address", "Rating", "Price"]
#   yelp_results_hash["businesses"].each do |business|
#     rows << [business["name"], business["location"]["display_address"], business["rating"], business["price"]]
#   end
#   table = Terminal::Table.new :rows => rows
# end
