require "rubygems"
require "thor"

class Terminal < Thor
  
  COLOR_INFO      = :green
  COLOR_ERROR     = :red
  RAILS_VERSIONS  = []
  
  PROJECT_ROOT    = File.expand_path(File.dirname(__FILE__)).freeze
  TEMP_DIR        = File.join(PROJECT_ROOT, 'tmp').freeze
  RAILS_ROOT      = File.join(TEMP_DIR, 'rails_root').freeze
  
  attr_accessor :rails_version
  
  desc "applicable rails versions", "Retreives the list of rails version to test this with"
  def applicable_rails_version
    @rails_version = IO.read('SUPPORTED_RAILS_VERSIONS').strip.split("\n")
  end
    
  desc "check rails version is installed", "Checks if the version of rails is installed on the system"
  def create_rails_application
    @rails_version.each do |version|
      `rails _#{version}_ #{RAILS_ROOT}`
      say "Generated rails #{version} application", COLOR_INFO
      remove_rails_application
    end
  end
  
  desc "create a temp directory", "Creates a temp directory where all the processing is done"
  def create_temp_directory
    FileUtils.mkdir_p(TEMP_DIR)
  end
  
  desc "clean rails application directory", "Cleans the rails application directory before a new rails version is used"
  def remove_rails_application
    FileUtils.rm_rf(RAILS_ROOT)
  end
  
  desc "cleans up", "Removes the temp directory"
  def clean_up
    FileUtils.rm_rf(TEMP_DIR)
  end
  
  desc "run script", "Runs through the entire script"
  def self.run_script
    terminal = Terminal.new
    yield terminal
  end
  
end

Terminal.run_script do |terminal|
  terminal.applicable_rails_version
  terminal.create_temp_directory
  terminal.create_rails_application
  terminal.clean_up
end
