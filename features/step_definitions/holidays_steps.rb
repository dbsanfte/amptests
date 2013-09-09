require 'watir-webdriver'
require 'rubygems'
require_relative '../support/pagemodel.rb'

Given(/^I request a new holiday$/) do
  if @pageModel.HolidaysLink.exists?
    @pageModel.HolidaysLink.click
  end
  @pageModel.NewHolidayRequestLink.when_present.click
end

Then(/^I expect a link to a new holiday request at "(.*?)" to appear on the page\.$/) do |arg1|
  @pageModel.ViewAllHolidayRequestsLink.when_present.click
  @browser.link(:text => @startDate).wait_until_present
end

Then(/^I expect no holiday to be added$/) do
  @browser.goto @BASEURL + '/Landing/Pad'
  @pageModel.ProfileLink.when_present.click
  @pageModel.HolidaysLink.when_present.click
  assert { @browser.link(:text => @startDate).exists? == false }
end
