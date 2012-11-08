require "selenium" 
require "csv"
require File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/PageConstants/FleetSearchPage')
require File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/LibraryFiles/Reusable_methods')
require File.join(File.dirname(File.expand_path(File.dirname(__FILE__)))+'/LibraryFiles/Constants')


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
      Results("#{testcase_no}"+"-1", "Search results for vehciles with unit# were displayed correctly", "PASS", "")
      #click on vehcile request link
      @driver.find_element(:link, VehicleRequest_Link).click
    else
      Results("#{testcase_no}"+"-1", "Search results for vehciles with unit# were displayed incorrectly", "FAIL", $error_screenshots)	
    end
  else
   Results("#{testcase_no}", "No entries were found for the search performed for unit#", "PASS", "")    
  end  
 end   
    
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
      Results("#{testcase_no}"+"-1", "Search results for vehciles with serial# were displayed correctly", "PASS", "")
    else
      Results("#{testcase_no}"+"-1", "Search results for vehciles with serial# were displayed incorrectly", "FAIL", $error_screenshots)	
    end
  else
   Results("#{testcase_no}", "No entries were found for the search performed for serial#", "PASS", "")    
  end  
 end      
  
  def Search_Service_Location_With_Name(name, testcase_no)
    @driver.find_element(:id, ServiceLocationName_EB).clear
    @driver.find_element(:id, ServiceLocationName_EB).send_keys "#{name}"
    @driver.find_element(:name, Commit_Btn).click
    search_locations = @driver.find_element(:css, ServiceLocationSearchResults_ID).text
    str = search_locations
    no_of_locations= str.scan(/\d+/)[0]
    i=1
    j=1
    flag=0
   if("No entries found" != @driver.find_element(:css, ServiceLocationSearchResults_ID).text)
     while(i<=(no_of_locations).to_i)
  	if(@driver.find_element(:xpath, "//div[@id='rarea_wrapper']/div[7]/table/tbody/tr[#{j}]/td[2]/a").text =~/[#{name}](.*)/)   
          flag= flag+1		
	else 
	 Results("#{testcase_no}", "#{i} row doesn't contain the searched service location name ", "FAIL", $error_screenshots)	
        end	
        i=i+1
	j=j+2
     end
     if (flag == (no_of_locations).to_i)
        Results("#{testcase_no}"+"-1", "The results for the searched service location name were displayed correctly", "PASS", "")
     else
      Results("#{testcase_no}"+"-1", "The results for the searched service location name were displayed incorrectly", "FAIL", $error_screenshots)	
     end
  else
    Results("#{testcase_no}", "No entries were found for the searched service location", "PASS", "")    
  end  
 end	  

  def Search_Service_Location_With_Location(location, testcase_no)
    @driver.find_element(:id, ServiceLocationLocation_EB).clear
    @driver.find_element(:id, ServiceLocationLocation_EB).send_keys "#{location}"
    @driver.find_element(:name, Commit_Btn).click
    search_locations = @driver.find_element(:css, ServiceLocationSearchResults_ID).text
    str = search_locations
    no_of_locations= str.scan(/\d+/)[0]
    string="#{location}"
    loc=string.split(",")[0]
    puts loc
    i=1
    j=1
    flag=0
   if("No entries found" != @driver.find_element(:css, ServiceLocationSearchResults_ID).text)
     while(i<=(no_of_locations).to_i)
  	if((@driver.find_element(:xpath, "//div[@id='rarea_wrapper']/div[7]/table/tbody/tr[#{j}]/td[6]").text =~/[#{location}](.*)/)||(@driver.find_element(:xpath, "//div[@id='rarea_wrapper']/div[7]/table/tbody/tr[#{j}]/td[5]").text =~/[#{location}](.*)/)||(@driver.find_element(:xpath, "//div[@id='rarea_wrapper']/div[7]/table/tbody/tr[#{j}]/td[5]").text =~/[#{loc}](.*)/))  
          flag= flag+1		
	else 
	 Results("#{testcase_no}", "#{i} row doesn't contain the searched service location", "FAIL", $error_screenshots)	
        end	
        i=i+1
	j=j+2
     end
     if (flag == (no_of_locations).to_i)
        Results("#{testcase_no}"+"-1", "The results for the searched service location were displayed correctly", "PASS", "")
     else
      Results("#{testcase_no}"+"-1", "The results for the searched service location were displayed incorrectly", "FAIL", $error_screenshots)	
     end
  else
    Results("#{testcase_no}", "No entries were found for the searched service location", "PASS", "")    
  end  
 end	  
  
   def Create_Service_Request(vehicle_no, complaint, note, contact_no, driver_name, driver_no, breakdown_location, breakdown_city, breakdown_state, testcase_no)
    service_location = @driver.find_element(:xpath, ServiceRequestFirstServiceLocationName_ID).text
    @driver.find_element(:link, ServiceRequest_Link).click
    @driver.find_element(:name, ServiceRequestComplaint_EB).clear
    @driver.find_element(:name, ServiceRequestComplaint_EB).send_keys "#{complaint}"
    @driver.find_element(:name, ServiceRequestNotes_EB).clear
    @driver.find_element(:name, ServiceRequestNotes_EB).send_keys "#{note}"
    @driver.find_element(:id, ServiceRequestPrimaryContactPhone_EB).clear
    @driver.find_element(:id, ServiceRequestPrimaryContactPhone_EB).send_keys "#{contact_no}"
    @driver.find_element(:id, ServiceRequestDriverName_EB).clear
    @driver.find_element(:id, ServiceRequestDriverName_EB).send_keys "#{driver_name}"
    @driver.find_element(:id, ServiceRequestDriverPhone_EB).clear
    @driver.find_element(:id, ServiceRequestDriverPhone_EB).send_keys "#{driver_no}"
    @driver.find_element(:id, ServiceRequestBreakdownLocation_EB).clear
    @driver.find_element(:id, ServiceRequestBreakdownLocation_EB).send_keys "#{breakdown_location}"
    @driver.find_element(:id, ServiceRequestBreakdownCity_EB).clear
    @driver.find_element(:id, ServiceRequestBreakdownCity_EB).send_keys "#{breakdown_city}"
    Selenium::WebDriver::Support::Select.new(@driver.find_element(:id, ServiceRequestBreakdownState_DD)).select_by(:index, "1")
    user =@driver.find_element(:xpath, ServiceRequestForUser_DD).text
    puts user
    if("#{user}"=~/[-](.*)/)
       string="#{user}"
       user=string.split(" -")[0]
       puts user
    end
    @driver.find_element(:xpath, ServiceRequestSubmit_Btn).click
    sleep 8
    puts "Sent request for estimate to #{user} at #{service_location}."
    puts @driver.find_element(:css, Flash_Notice).text
    if("Sent request for estimate to #{user} at #{service_location}."==(@driver.find_element(:css, Flash_Notice).text))
      Results("#{testcase_no}", "Flash notice was displayed when fleet Service request was submitted", "PASS", "")
    else
      Results("#{testcase_no}", "Flash notice was not displayed when fleet Service request was submitted", "FAIL", $error_screenshots)	    
    end
    #Verify service request created
    @driver.find_element(:id, DealerHomePageSwitch_Link).click
    @driver.find_element(:css, DealerSelectSwitch_Link).click
    @driver.find_element(:xpath, UnitNoColumn_ID).click
    sleep 6
    @driver.find_element(:xpath, CreatedColumn_ID).click
    sleep 6
    if(((@driver.find_element(:css, ReqServiceFirstRowUnitNo_ID).text=~/[#{vehicle_no}](.*)/)||(@driver.find_element(:xpath, ReqServiceFirstRowSerialNo_ID).text=~/[#{vehicle_no}](.*)/))&&("#{service_location}"== @driver.find_element(:xpath, ReqServiceFirstRowServiceLocation_ID).text)&&("#{user}"== @driver.find_element(:xpath, ReqServiceFirstRowAssignedUser_ID).text ))
       Results("#{testcase_no}-1", "Fleet Service request was created successfully", "PASS", "")
    else
      Results("#{testcase_no}-1", "Fleet service request was not created", "FAIL", $error_screenshots)	 
    end	    
end 

