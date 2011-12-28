require 'bundler'
Bundler.require

END_POINT = 'http://www.gmail.com'
REGEX_TO_MATCH = /^Viatask Invi/

agent = Mechanize.new
page = agent.get(END_POINT)

form = page.forms.first
puts "Please enter your email:"
form.Email = gets

puts "Please enter your password:"
form.Passwd = gets

puts "Processing..."
puts "-----------------------------------------\n\n"

page = agent.submit form
gmail_page = nil

page.links.each do |link|
  text = link.text.strip
  if REGEX_TO_MATCH.match(text)
    gmail_page = link.click
  end
  next unless text.length > 0
end

node_set = gmail_page.search("font").find_all { |node| node['color'] == "#7777CC" }

1.upto(5).each do |index|
  gmail_page.links.each do |link|
    text = link.text.strip
    if /^Older/.match(text)
      gmail_page = link.click
      node_set.concat(gmail_page.search("font").find_all { |node| node['color'] == "#7777CC" })
    else
      next
    end
  end
end

node_set.each do |node|
  puts node.inner_html.match(/- (.*) requested an invite on the Viatask cooming soon page/)[1]
end
