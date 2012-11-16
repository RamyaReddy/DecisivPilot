# *************************************************************************************************************************************************************************
# Script Name: Decisiv_driver_script.rb
# **************************************************************************************************************************************************************************
# Product: Mvasist
# Operating System : Windows 7 
# Selenium webdriver 2.25 and   Ruby  - 1.9.2
# Browser : Firefox 15.0
# **************************************************************************************************************************************************************************
# Description:   

# 1. Call FleetServiceRequest_FromDashboard.rb file to create service request from dashboard page
# 2. Call FleetServiceRequest_FromSearchPage.rb to create service request from search page
# 3. Call FleetServiceRequest_WithSerialNo.rb to create service request from show vehicle page by seraching with serial#

# ***************************************************************************************************************************************************************************
# Recorded/Authored By : ZenQA            Date: 16-Nov-2012
# Updated                    : 16-Nov-2012
#****************************************************************************************************************************************************************************
 
 require File.expand_path(File.dirname(__FILE__))+'/FleetServiceRequest_FromDashboard'
 require File.expand_path(File.dirname(__FILE__))+'/FleetServiceRequest_FromSearchPage'
 require File.expand_path(File.dirname(__FILE__))+'/FleetServiceRequest_WithSerialNo'
 require 'yaml'
 
 class Decisiv_Driver_Script

  def test_Decisiv_driver_Script
    
    Test01_FleetRequest_FromDashboardPage.new
    Test02_FleetRequest_FromSearchPage.new
    Test03_FleetRequest_WithSerialNo.new
    
  end
  
end
