# *************************************************************************************************************************************************************************
# Script Name: FleetServiceRequest_WithSerialNo.rb
# **************************************************************************************************************************************************************************
# Product: Mvasist
# Operating System : Windows 7 
# Selenium webdriver 2.25 and   Ruby  - 1.9.2
# Browser : Firefox 15.0
# **************************************************************************************************************************************************************************
# Description:   
# Create fleet service request by show vehicle page by searching with serial# of vehicle
# ***************************************************************************************************************************************************************************
# Recorded/Authored By : ZenQA            Date: 16-Nov-2012
# Updated                    : 16-Nov-2012
#*************************************************PRE CONDITONS ********************************************************************************************************
# URL : Mention the test environment in $env variable at the begining of the script
#************************************************ POST CONDITIONS******************************************************************************************************
# log file              : FleetRequest_WithSerialNo.html
#***************************************************************************************************************************************************************************

require "selenium-webdriver"
require File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/LibraryFiles/Reusable_methods')
require File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/PageParts/LoginPage')
require File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/PageParts/FleetSearchPage')
require File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/PageParts/RequestServicePage')
require "test/unit"
require 'yaml'

class Test03_FleetRequest_WithSerialNo < Test::Unit::TestCase

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
     @driver.manage.timeouts.implicit_wait = 60
     @verification_errors = []
  end
  
    # Create a log file 
      Folder_Exists(File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/Reports'))
      $logfile = File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/Reports/FleetRequest_WithSerialNo.html')
      $error_screenshots = File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/ErrorScreenshots/FleetRequest_WithSerialNo')
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
  #* 2.  User searches for a vehicle with serial# and verifies the search results
  #* 3.  User verifies that vehicles exists with searched serial#, navigates to show vehicle page and if no results were found, logs a message and stops script execution
  #* 4.  Searches for a service location and verifies that the search results were displayed correctly
  #* 5.  Creates service request for the searched service location and verifies the created  fleet service request from home page   
    
  def test_FleetRequest_WithSerialNo
    # Navigate to the volvo demo site
    @driver.get $env
    
    #1. Login to the application 
    Login($uname, $pwd, "1.0") 
    
    #2. Perform vehicle search with serial# and verify the search results 
    VehicleSearchWithSerial_No("123", "2")
    
    #3. Click on Serial# link 
    if("No entries found"!=(@driver.find_element(:css, VehicleSearchResults_ID).text))
           Results("3.0", "Vehicles exists with the searched serial# and hence can view the show vehicle page of first displayed vehicle", "PASS", "")
	   @driver.find_element(:css, VehicleFirstRowSerialNo_ID).click
     #3.1. Click on request service button. 
           @driver.find_element(:xpath, RequestService_Btn).click	 
    
    #4. Perform service location search with location field and verify the search results
    Search_Service_Location_With_Location("Dallas,TX", "4")
    
    #5. Create service request for the searched vehicle and service location and submit the request.
    Create_Service_Request("123","Engine failure", "Please respond immediately", "9876543210", "testdriver", "9876543210", "street1", "Dallas", "Virginia", "5")
    else 
	Results("3.0", "Vehicles doesn't exists with the searched serial# and hence cannot view the show vehicle page", "FAIL", $error_screenshots) 
    end 
 end
    
end