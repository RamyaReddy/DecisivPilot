require "selenium"
require "csv"
require 'yaml'
require File.expand_path(File.dirname(__FILE__))+'/Constants'
$config = YAML.load_file('../Config/config_properties.yaml')['Demo']
$test_browser = $config['FFBrowser']


def Folder_Exists(path)
	Dir.mkdir(path) unless File.exists?(path)
end


#* Purpose      : To capture  the screenshot and save in the Error Screenshots folder 
#* Returns      : None
#* Parameters  : path and testcase no
def Capture_Screenshot(path, testcase_no)
    filename = File.join("#{path}"+'/'+"#{testcase_no}"+'.png')
    screen = filename.gsub('/', '\\')
    $shot= "file:///"+screen
    @driver.save_screenshot(filename)
 end


#* Purpose      : To get the current date and time
#* Returns      : None
#* Parameters  : none
def Current_Date_Time()
    $time_date = Time.now
    $current_time = $time_date.strftime("%I:%M:%S")
    $current_date = $time_date.strftime("%m/%d/%Y")
end


#* Purpose      : To create log in the html file
#* Returns      : None
#* Parameters  : checkpoint, result(takes only 2 values PASS/FAIL), screenshot location and testcase no
def Results(testcase_no, checkpoint, result, screenshot)
        Current_Date_Time()
	$fileHtml.puts "</td><tr><td width=110><font size=2 face=verdana>"
	$fileHtml.puts "#{testcase_no}"
	$fileHtml.puts "</td><td width=400><font size=2 face=verdana>"
	$fileHtml.puts "#{checkpoint}"
  	if ("#{result}" == "PASS")
       $fileHtml.puts "</td><td width=100 bgcolor=green><font size=2 face=verdana color=white><center><font color=white>"
	  elsif ("#{result}" == "FAIL")
	 Capture_Screenshot(screenshot, testcase_no)	  
       $fileHtml.puts "</td><td width=100 bgcolor=red><font size=2 face=verdana color=white><center><a href ='" + "#{$shot}" + "'><font color=white>"
	  else
       $fileHtml.puts "</td><td width=100 bgcolor=SeaShell><font size=2 face=verdana color=white><center>"
	  end
       $fileHtml.puts "#{result}"
       $fileHtml.puts "</a>"
       $fileHtml.puts "</td><td width=110><font size=2 face=verdana><center>"
       $fileHtml.puts "#{$current_time}"+" "+"#{$current_date}"
       $fileHtml.puts "</td>"
end


#* Purpose      : To create the start exceution summary report in the html file
#* Returns      : None
#* Parameters  : logfile location
def Summary(logfile)
      $time = Time.new
      $fileHtml = File.new("#{logfile}", "w+")
      $fileHtml.puts "<div> 
      <img src='../Attachments/mvasist_logo.jpg' align='right' size=2 />
      <img src='../Attachments/zen_logo.png' align='left' size=2 />
      <br><br><br><br><br><br></div>"
      $fileHtml.puts "<html><head><title>Results</title></head><body><br><center><font size=5 face=candara><b>Test Execution Summary<br><center><table border=1 width=610><tr>"
      $fileHtml.puts "<body><br><center><font size=4 face=candara><b>Script execution started at #{$time.strftime("%b-%d %H:%M:%S")}<br>"
      $fileHtml.puts "<tr><td bgcolor=#153E7E width=110><b><font color=white><center>Test Case #</td><td bgcolor=#153E7E width=400><b><font color=white><center>Test Scenario</td><td bgcolor=#153E7E width=100><b><font color=white><center>Result</td><td bgcolor=#153E7E width=110><b><font color=white><center>Execution Time</td><tr>"
end	


#* Purpose      : To save the  end execution sumary report 
#* Returns      : None
#* Parameters  : logfile location
def End_Summary(logfile)
    $time = Time.new
    $fileHtml.puts "<body><br><center><font size=4 face=candara><b>Script execution ended at #{$time.strftime("%b-%d %H:%M:%S")}<br><br><br><center><table border=1 width=610><tr>"
    $fileHtml.close()
end    


#* Purpose      : To wait for a specific elemen till the timeout expires
#* Returns      : returns True when element is located within timeout period else returns false
#* Parameters  : locator type(say css, xpath, id, name etc) and locator value
def Wait_For_Element(locator_type, locator_value)
   for iSecond in 0..$config['Longwait']
     sleep 1
     if(@driver.find_element("#{locator_type}", "#{locator_value}").displayed?)
	break
     else 	
     if (iSecond >= $config['Longwait']) 
       return false
       @driver.find_element("#{locator_type}", "#{locator_value}").displayed?
       break
     end
    end 
  end
  return true
end	