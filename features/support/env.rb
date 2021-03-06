require 'watir-webdriver'
require 'rubygems'
#require ' test/unit'
require 'rspec/expectations'
require_relative 'pagemodel.rb'
 
# attempt to resolve login box issues:
profile = Selenium::WebDriver::Firefox::Profile.new 
profile['network.automatic-ntlm-auth.trusted-uris'] = 'amptest.bjss.com'
profile['browser.safebrowsing.malware.enabled'] = false
profile['services.sync.prefs.sync.browser.safebrowsing.malware.enabled'] = false

browser = Watir::Browser.new :firefox, :profile => profile
 
Before do
  @browser = browser
  @pageModel = AmpPageModel.new(@browser)
  @browser.goto 'http://APMTest:cr8qECeb@amptest.bjss.com/'
  @pageModel.LandingLink.wait_until_present
  @BASEURL = 'http://amptest.bjss.com/'
end
 
at_exit do
  #browser.close
end

