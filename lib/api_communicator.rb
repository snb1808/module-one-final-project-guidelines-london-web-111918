require 'pry'
require "json"
require "http"
require "optparse"

API_KEY = "TAvAEQQevf48K2fn_gSWj2m6spnxp0qDzV5IdJ4L0hBhKqlM3jaAfxxL35m1ja1AMdfPeCdhgiqoS6ifQ-uoXT_VlrZ-3rPKLYLM8sQoQacH_mKeHmMTaDx__EMGXHYx"

API_HOST = "https://api.yelp.com"
SEARCH_PATH = "/v3/businesses/search"
BUSINESS_PATH = "/v3/businesses/"

DEFAULT_BUSINESS_ID = "yelp-san-francisco"
DEFAULT_TERM = "dinner"
DEFAULT_LOCATION = "San Francisco, CA"
SEARCH_LIMIT = 10

def search(term, location)
  url = "#{API_HOST}#{SEARCH_PATH}"
  params = {
    term: term,
    location: location,
    limit: SEARCH_LIMIT
  }

  response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
  response.parse
end

def save_table(hash)
  hash["businesses"].each do |array|
    array.each do |business|
    new = Business.new
    new.name = business["name"]
    new.website = business["url"]
    new.review_count = business["review_count"]
    new.rating = business["rating"]
    new.price = business["price"]
    new.location = business["location"]["display_address"]
    new.phone = business["phone"]
  end
end
end

def search_and_add_businesses(term, location)
  results_hash = search(term, location)
  save_table(results_hash)
end
