require "selenium-webdriver"
require File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/LibraryFiles/Reusable_methods')
require File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/PageParts/LoginPage')
require File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/PageParts/FleetSearchPage')
require "test/unit"
require 'yaml'

class Fleet_Request_Test < Test::Unit::TestCase

  def setup
    @verification_errors = []
     $config = YAML.load_file('../Config/config_properties.yaml')['Demo']
    if $driver
      @driver = $driver
    else
	#$env = "http://volvo.demo.decisiv.net/"
         #$uname="zenqafleet"
         #$pwd= "g00dt3st!ng"
      $test_browser = $config['FFBrowser']
      $env = $config['url']
      $uname=$config['username1']
      $pwd=$config['password1']
     @driver = Selenium::WebDriver.for :"#{$config['FF_Browser']}"
     @driver.manage().window.maximize()
     @driver.manage.timeouts.implicit_wait = 60
     @verification_errors = []
  end
  
    # Create a log file 
      Folder_Exists(File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/Reports'))
      $logfile = File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/Reports/Fleet_Request.html')
      $error_screenshots = File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/ErrorScreenshots/Fleet_Request')
      Folder_Exists($error_screenshots)
                 
      # Search for the log file and if it exist delete the file 
      if (FileTest.exist?($logfile))
        File.delete($logfile)
      end
      Summary($logfile)
  end
  
  def teardown
    End_Summary($logfile)    
    @driver.quit
    assert_equal [], @verification_errors
  end

  def test_Example
    @driver.get $env
    Login($uname, $pwd, "1.0") 
    VehicleSearchWithUnit_No("222", "1.1")
    Search_Service_Location_With_Location("Dallas,TX", "1.2")
    Create_Service_Request("123","Engine failure", "Please respond immediately", "9876543210", "testdriver", "9876543210", "street1", "Dallas", "Virginia", "1.3")
 end
    
end
