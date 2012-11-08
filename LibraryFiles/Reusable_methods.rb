require "selenium"
require "csv"
require File.expand_path(File.dirname(__FILE__))+'/Constants'


def Folder_Exists(path)
	Dir.mkdir(path) unless File.exists?(path)
end


#* Purpose      : to capture screenshot and save in the Error Screenshots folder 
#* Returns      : None
#* Parameters  : path and testcase no
def Capture_Screenshot(path, testcase_no)
    filename = File.join("#{path}"+'/'+"#{testcase_no}"+'.png')
    screen = filename.gsub('/', '\\')
    $shot= "file:///"+screen
    @driver.save_screenshot(filename)
 end

def Current_Date_Time()
    $time_date = Time.now
    $current_time = $time_date.strftime("%I:%M:%S")
    $current_date = $time_date.strftime("%m/%d/%Y")
end

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

def End_Summary(logfile)
    $time = Time.new
    $fileHtml.puts "<body><br><center><font size=4 face=candara><b>Script execution ended at #{$time.strftime("%b-%d %H:%M:%S")}<br><br><br><center><table border=1 width=610><tr>"
    $fileHtml.close()
end    

