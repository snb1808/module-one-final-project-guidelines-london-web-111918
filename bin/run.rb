
require 'pry'
require 'terminal-table'
require_relative '../config/environment'
require_relative "../lib/command_line_interface.rb"




welcome
username = stored_name_input
username_search(username)
choice = options.to_i

case choice
  when 1
    run_option_1
  when 2
    run_option_2(username)
  when 3
    run_option_3
  else
    puts "\n \n"
    puts "Please choose a number between 1 and 3"
  end
