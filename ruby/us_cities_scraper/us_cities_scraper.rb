require 'erb'
require 'open-uri'
require 'bundler'
Bundler.require

US_STATES = [ "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida",
              "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas","Kentucky", "Louisiana", "Maine", "Maryland",
              "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New-Hampshire",
              "New-Jersey", "New-Mexico", "New-York", "North-Carolina", "North-Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania",
              "Rhode-Island", "South-Carolina", "South-Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington",
              "West-Virginia", "Wisconsin", "Wyoming"]

CSS_EXPRESSION_TO_MATCH = 'tr.rB td a'

url_template = ERB.new "http://www.city-data.com/city/<%= state %>.html"

us_cities = {}
sql_statements = []

US_STATES.each do |state|
  puts "For state of #{state}"

  url = url_template.result(binding)
  puts "Making request at #{url}"

  doc = Nokogiri::HTML(open(url))
  results = []

  doc.css(CSS_EXPRESSION_TO_MATCH).children.each do |node|
    results << node.to_s
  end

  puts "Preparing SQL statements for #{state}"
  results.each do |result|
    # because some cities have comma in them and in SQL that would
    # cause a problem because , is used in sql as a value separator
    if result.index(",")
      result = result.gsub(",", " -")
    end
    if result.index("'")
      result = result.gsub("'", "''")
    end

    if state.index("-")
      state = state.gsub("-", " ")
    end
    sql_statements << "INSERT INTO CITIES(name, state, created_at, updated_at, launched) VALUES ('#{result}', '#{state}', '2011-10-26 04:05:06', '2011-10-26 04:05:06', false);"
  end
end

File.open("us_cities_sql", 'w+') do |file|
  file.write sql_statements.join("\n")
end
