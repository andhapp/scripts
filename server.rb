require 'webrick'
include WEBrick
destination = ARGV.shift.dup
s = HTTPServer.new(:Port => 9000, :DocumentRoot => destination)
t = Thread.new { s.start }
trap("INT") { s.shutdown }
t.join()