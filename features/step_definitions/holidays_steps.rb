require 'watir-webdriver'
require 'rubygems'
require_relative 'calendar.rb'
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

Given(/^I request a new holiday$/) do
  if @pageModel.HolidaysLink.exists?
    @pageModel.HolidaysLink.click
  end
  @pageModel.NewHolidayRequestLink.when_present.click
end

Given(/^a start date of "(.*?)"$/) do |arg1|

  @pageModel.StartDateTextField.when_present.click
  @pageModel.StartDateTextField.fire_event('onfocus')

  Calendar.new(@browser).setDate(arg1)
  Watir::Wait.until { @pageModel.StartDateTextField.value == arg1 }
  
  assert { @pageModel.StartDateTextField.value == arg1 }
  @startDate = arg1 # save this for a later verification step

end

Given(/^a start time of "(.*?)"$/) do |arg1|
  
  if arg1 != 'AM' && arg1 != 'Midday'
    raise Exception, 'input should be AM or Middday'
  end

  @pageModel.StartTimeDropdownList.exists?
  @pageModel.StartTimeDropdownList.select arg1
end

Given(/^an end date of "(.*?)"$/) do |arg1|

  @pageModel.FinishDateTextField.when_present.click
  @pageModel.FinishDateTextField.fire_event('onfocus')

  Calendar.new(@browser).setDate(arg1)
  Watir::Wait.until { @pageModel.FinishDateTextField.value == arg1 }

  assert { @pageModel.FinishDateTextField.value == arg1 }
end

Given(/^an end time of "(.*?)"$/) do |arg1|
  
  if arg1 != 'PM' && arg1 != 'Midday'
    raise Exception, 'input should be PM or Midday'
  end

  @pageModel.FinishTimeDropdownList.exists?
  @pageModel.FinishTimeDropdownList.select arg1
end

Given(/^a duration of "(.*?)"$/) do |arg1|
  @pageModel.DurationTextField.set arg1
end

Given(/^information of "(.*?)"$/) do |arg1|
  @pageModel.InformationTextField.set arg1
end

Given(/^there are no data validation errors$/) do
  if @pageModel.FieldValidationError.exists?
    raise Exception, 'data validation error present in form'
  end
end

When(/^I click Save$/) do
  @pageModel.PopupSaveButton.click
end

Then(/^I expect a link to a new holiday request at "(.*?)" to appear on the page\.$/) do |arg1|
  @pageModel.ViewAllHolidayRequestsLink.when_present.click
  @browser.link(:text => @startDate).wait_until_present
end

When(/^I see the duration calculated$/) do
  Watir::Wait.until { @pageModel.DurationTextField.value != '' }
end

Then(/^I expect a duration of "(.*?)"$/) do |arg1|
  assert { @pageModel.DurationTextField.value == arg1 }
end

When(/^I close the add holiday popup window$/) do
  @pageModel.PopupWindowCloseButton.click
end

When(/^I click cancel$/) do
  @pageModel.PopupCancelButton.click
end

Then(/^I expect the holiday window to close$/) do
  Watir::Wait.until { @pageModel.PopupSaveButton.exists? == false }
end

Then(/^I expect no holiday to be added$/) do
  @browser.goto @BASEURL + '/Landing/Pad'
  @pageModel.ProfileLink.when_present.click
  @pageModel.HolidaysLink.when_present.click
  assert { @browser.link(:text => @startDate).exists? == false }
end

Given(/^I request a new absence$/) do
  if @pageModel.AbsencesLink.exists?
    @pageModel.AbsencesLink.click
  end
  @pageModel.NewAbsenceRequestLink.when_present.click
  @pageModel.PopupSaveButton.wait_until_present # wait for page load
end

Given(/^a reason of "(.*?)"$/) do |arg1|
  if arg1 != 'Please select a reason' && arg1 != 'Other absence' && arg1 != 'Illness' && arg1 != 'Working From Home' && arg1 != 'Out Of Office Appointment'
    raise Exception, 'input should be one of: Please select a reason, Other absence, Illness, Working From Home, Out Of Office Appointment'
  end

  list = @browser.select_list :id => 'AReason_AbsenceReasonId'
  list.exists?
  list.select arg1
end

Then(/^I expect a link to a new absence request at "(.*?)" to appear on the page\.$/) do |arg1|
  @browser.goto @BASEURL + '/Landing/Pad'
  @pageModel.ProfileLink.when_present.click
  @pageModel.AbsencesLink.when_present.click
  assert { @browser.link(:text => @startDate).exists? == false }
end
