require 'watir-webdriver'
require 'rubygems'
require_relative '../support/pagemodel.rb'

# roll our own assert method
def assert
  raise Exception unless yield
end

Given(/^I am logged in as the Automation Test User$/) do
  @browser.goto 'http://APMTest:cr8qECeb@amptest.bjss.com/' 
end

Given(/^I am on the landing page$/) do
  @browser.goto @BASEURL + '/Landing/Pad'
  @pageModel.LandingLink.when_present.click
end

Given(/^I am on the profile page$/) do
  @browser.goto @BASEURL + '/Landing/Pad'
  @pageModel.ProfileLink.when_present.click
  @pageModel.HolidaysLink.wait_until_present # wait for pageload
end

