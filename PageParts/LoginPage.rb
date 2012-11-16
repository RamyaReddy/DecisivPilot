require "selenium" 
require "csv"
require File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/PageConstants/LoginPage')
require File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/LibraryFiles/Reusable_methods')
require File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/LibraryFiles/Constants')

#*  Purpose           :  Login to the application
#*  Return Value    : None   
#*  Parameters      :  Username, Password and testcase # in which teh function is called
def Login(username, password, testcase_no) 
    @driver.find_element(:id, LoginMenu_Link).click
    @driver.find_element(:id, UserName_EB).clear
    @driver.find_element(:id, UserName_EB).send_keys "zenqafleet"
    @driver.find_element(:id, Password_EB).clear
    @driver.find_element(:id, Password_EB).send_keys "g00dt3st!ng"
    @driver.find_element(:name, Login_Btn).click
    if("You have successfully logged in."==(@driver.find_element(:css, Flash_Notice).text ))
      Results("#{testcase_no}", "Logged into the application successfully", "PASS", "")
    else
      Results("#{testcase_no}", "Couldn't login to the application", "FAIL", $error_screenshots)	
    end  
end