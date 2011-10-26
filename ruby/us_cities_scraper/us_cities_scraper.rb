require 'erb'
require 'open-uri'
require 'bundler'
Bundler.require

US_STATES = [ "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida",
              "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas","Kentucky", "Louisiana", "Maine", "Maryland",
              "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire",
              "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania",
              "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington",
              "West Virginia", "Wisconsin", "Wyoming"]

US_STATES = [ "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida"]

CSS_EXPRESSION_TO_MATCH = 'tr.rB td a'

url_template = ERB.new "http://www.city-data.com/city/<%= state %>.html"

us_cities = {}

US_STATES.each do |state|
  puts "For state of #{state}"

  url = url_template.result(binding)
  puts "Making request at #{url}"

  doc = Nokogiri::HTML(open(url))
  results = []

  doc.css(CSS_EXPRESSION_TO_MATCH).children.each do |node|
    results << node.to_s
  end
  us_cities[state] = results
end


