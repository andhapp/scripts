%w{find fileutils}.each{|x| require "#{x}"}
root_directory_path = "C:\\Projects\\Ford projects\\DealerPieces\\TrunkFOI"
Find.find(root_directory_path) {|path| FileUtils.rmtree path if path =~ /.svn/ && FileTest.directory?(path) }
