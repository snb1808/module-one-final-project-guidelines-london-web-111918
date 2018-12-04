require 'pry'
require_relative '../config/environment'

pry.Start

username = welcome

username_search(username)

choice = options

until choice < 4 || choice > 0
  choice = options
end

case choice
when 1
  run_option_1
when 2
  run_option_2
when 3
  run_option_3
end
