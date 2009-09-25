require "metaid"

class MailTruck
   def self.company( name )
     meta_def :company do; name; end #when this method gets executed self is HapyTruck therefore a company method is added to HappyTruck and not MailTruck
   end
 end


class HappyTruck < MailTruck
  company("Happy's -- We Bring the Mail, and That's It!")
end

puts MailTruck.company("anuj")
puts HappyTruck.company