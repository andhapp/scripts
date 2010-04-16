gem_list = {  
  "rails" => "2.3.5", 
  "formtastic" => "0.9.1",  
  "shoulda" => "2.10.3",
  "factory_girl" => "1.2.3",
  "cucumber" => "0.6.2",
  "cucumber-rails" => "0.2.4",
  "webrat" => "0.6.0",
  "mocha" => "0.9.8",
  "jeweler" => "1.2.1",
  "sqlite3-ruby" => "1.2.1",
  "redgreen" => "1.2.2"
}

gem_list.each_pair {|key, value|
  system "gem dependency #{key} -v=#{value}"
}