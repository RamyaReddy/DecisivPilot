# *************************************************************************************************************************************************************************
# Script Name: FleetServiceRequest_FromDashboard.rb
# **************************************************************************************************************************************************************************
# Product: Mvasist
# Operating System : Windows 7 
# Selenium webdriver 2.25 and   Ruby  - 1.9.2
# Browser : Firefox 15.0
# **************************************************************************************************************************************************************************
# Description:   
# Create Fleet service request from dashboard page
# **************************************************************************************************************************************************************************
# Recorded/Authored By : ZenQA            Date: 16-Nov-2012
# Updated                    : 16-Nov-2012
#*************************************************PRE CONDITONS ********************************************************************************************************
# URL : Mention the test environment in $env variable at the begining of the script
#************************************************ POST CONDITIONS******************************************************************************************************
# log file              : FleetRequest_FromDashboardPage.html
#***************************************************************************************************************************************************************************

require "selenium-webdriver"
require File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/LibraryFiles/Reusable_methods')
require File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/PageParts/LoginPage')
require File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/PageParts/RequestServicePage')
require "test/unit"
require 'yaml'

class Test01_FleetRequest_FromDashboardPage < Test::Unit::TestCase

  def setup
    @verification_errors = []
     $config = YAML.load_file('../Config/config_properties.yaml')['Demo']
    if $driver
      @driver = $driver
    else
      $test_browser = $config['FF_Browser']
      $env = $config['url']
      $uname=$config['username1']
      $pwd=$config['password1']
     @driver = Selenium::WebDriver.for :"#{$config['FF_Browser']}"
     @driver.manage().window.maximize()
     @driver.manage.timeouts.implicit_wait = 100
     @verification_errors = []
  end
  
    # Create a log file 
      Folder_Exists(File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/Reports'))
      $logfile = File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/Reports/FleetRequest_FromDashboardPage.html')
      $error_screenshots = File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/ErrorScreenshots/FleetRequest_FromDashboardPage')
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
 
  
  ## Operation sperformed in FleetServiceRequest_FromDashboard script   
    #* 1.  User Login to application with valid credentials
    #* 2. User verifies that vehicles are displayed under requested service table and if not logs a message and stops script execution
           #* 2.1. Click on request service button.
    #*3. Searches for a service location and verifies that the search results were displayed correctly
    #*4.  Creates service request for the searched service location and verifies the created  fleet service request from home page   
  
  def test_FleetRequest_FromDashboardPage
	 # Navigate to the volvo demo site
           @driver.get $env
    
         #1. Login to the application 
            Login($uname, $pwd, "1.0") 
      
	 #2. Click on vehicle# link 
	 if("No entries found"!=(@driver.find_element(:css, RequestServicesTableSearchResults_ID).text))
           Results("2.0", "Requested services exists in the home page and hence can view the show vehicle page", "PASS", "")
	   @driver.find_element(:css, ReqServiceFirstRowUnitNo_ID).click
	 #2.1. Click on request service button. 
           @driver.find_element(:xpath, RequestService_Btn).click	 
	
         #3. Perform service location search with location field and verify the search results
           Search_Service_Location_With_Name("volvo", "3")
    
         #4. Create service request for the searched vehicle and service location and submit the request.
           Create_Service_Request("123","Engine failure", "Please respond immediately", "9876543210", "testdriver", "9876543210", "street1", "Dallas", "Virginia", "4")
	  else 
	   Results("2.0", "Requested services doesn't exists in home page and hence cannot view the show vehicle page", "FAIL", $error_screenshots) 
	 end 
  end
end
	  