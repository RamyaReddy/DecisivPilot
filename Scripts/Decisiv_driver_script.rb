 require File.expand_path(File.dirname(__FILE__))+'/FleetServiceRequest_FromDashboard'
 require File.expand_path(File.dirname(__FILE__))+'/FleetServiceRequest_FromSearchPage'
 require File.expand_path(File.dirname(__FILE__))+'/FleetServiceRequest_WithSerialNo'
 #require 'FleetServiceRequest_FromDashboard.rb'
 #require 'FleetServiceRequest_FromSearchPage.rb'
 #require 'FleetServiceRequest_WithSerialNo.rb'
 require 'yaml'
 
# Test Environemt 
$config = YAML.load_file('../Config/config_properties.yaml')['Demo']
$env = $config['url']

# Test Browser
$test_browser = $config['FFBrowser']

 class Decisiv_Driver_Script

  def test_Decisiv_driver_Script
    
    Test01_FleetRequest_FromDashboardPage.new
    Test02_FleetRequest_FromSearchPage.new
    Test03_FleetRequest_WithSerialNo.new
    
  end
  
end
