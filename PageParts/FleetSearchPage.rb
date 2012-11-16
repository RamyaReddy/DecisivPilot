require File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/PageConstants/FleetSearchPage')
require File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/LibraryFiles/Reusable_methods')
require File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/LibraryFiles/Constants')



#*  Purpose           :  Search for vehcile with unit# and verify the search results
#*  Return Value    : None   
#*  Parameters      :  unit# of the vehicle , testcase # in which the function is called
def VehicleSearchWithUnit_No(unit_no, testcase_no)
    @driver.find_element(:id, SearchMenu_Link).click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, VehicleSearchType_DD)).select_by(:text, "Unit")
    @driver.find_element(:name, VehicleSearch_EB).clear
    @driver.find_element(:name, VehicleSearch_EB).send_keys "#{unit_no}"
    @driver.find_element(:name, Commit_Btn).click
    search_vehicles = @driver.find_element(:css, VehicleSearchResults_ID).text
    str = search_vehicles
    no_of_vehicles= str.scan(/\d+/)[0]
    i=1
    j=2
    flag=0
   if("No entries found" != @driver.find_element(:css, VehicleSearchResults_ID).text)
    while(i<=(no_of_vehicles).to_i)
  	if(@driver.find_element(:xpath, "//div[@id='page_for_fleet_vehicles']/table/tbody/tr[#{j}]/td[2]").text =~/[#{unit_no}](.*)/)   
          flag= flag+1		
	else 
	 Results("#{testcase_no}", "#{i} row doesn't contain the searched unit# ", "FAIL", $error_screenshots)	
        end	
        i=i+1
	j=j+2
    end
    if (flag == (no_of_vehicles).to_i)
      Results("#{testcase_no}"+"-1", "Search results for vehicles with unit# were displayed correctly", "PASS", "")
      #click on vehcile request link
      @driver.find_element(:link, VehicleRequest_Link).click
    else
      Results("#{testcase_no}"+"-1", "Search results for vehicles with unit# were displayed incorrectly", "FAIL", $error_screenshots)	
    end
  else
   Results("#{testcase_no}", "No entries were found for the search performed for unit#", "PASS", "")    
  end  
 end   
    
 
#*  Purpose           :  Search for vehcile with serial# and verify the search results
#*  Return Value    : None   
#*  Parameters      :  serial# of the vehicle , testcase # in which the function is called
 def VehicleSearchWithSerial_No(serial_no, testcase_no)
    @driver.find_element(:id, SearchMenu_Link).click
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, VehicleSearchType_DD)).select_by(:text, "Serial")
    @driver.find_element(:name, VehicleSearch_EB).clear
    @driver.find_element(:name, VehicleSearch_EB).send_keys "#{serial_no}"
    @driver.find_element(:name, Commit_Btn).click
    search_vehicles = @driver.find_element(:css, VehicleSearchResults_ID).text
    str = search_vehicles
    no_of_vehicles= str.scan(/\d+/)[0]
    i=1
    j=2
    flag=0
   if("No entries found" != @driver.find_element(:css, VehicleSearchResults_ID).text)
    while(i<=(no_of_vehicles).to_i)
  	if(@driver.find_element(:xpath, "//div[@id='page_for_fleet_vehicles']/table/tbody/tr[#{j}]/td/a").text =~/[#{serial_no}](.*)/)   
          flag= flag+1		
	else 
	 Results("#{testcase_no}", "#{i} row doesn't contain the searched serial# ", "FAIL", $error_screenshots)	
        end	
        i=i+1
	j=j+2
    end
    if (flag == (no_of_vehicles).to_i)
      Results("#{testcase_no}"+"-1", "Search results for vehicles with serial# were displayed correctly", "PASS", "")
    else
      Results("#{testcase_no}"+"-1", "Search results for vehicles with serial# were displayed incorrectly", "FAIL", $error_screenshots)	
    end
  else
   Results("#{testcase_no}", "No entries were found for the search performed for serial#", "PASS", "")    
  end  
 end      
  
  
