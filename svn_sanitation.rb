%w{find fileutils}.each{|x| require "#{x}"}
root_directory_path = "specify_path_here"
Find.find(root_directory_path) {|path| FileUtils.rmtree path if path =~ /.svn/ && FileTest.directory?(path) }
