require 'watir-webdriver'
require 'rubygems'
require_relative '../support/pagemodel.rb'
require_relative 'calendar.rb'

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

When(/^I see the duration calculated$/) do
  Watir::Wait.until { @pageModel.DurationTextField.value != '' }
end

Then(/^I expect a duration of "(.*?)"$/) do |arg1|
  assert { @pageModel.DurationTextField.value == arg1 }
end

When(/^I close the popup window$/) do
  @pageModel.PopupWindowCloseButton.click
end

When(/^I click cancel$/) do
  @pageModel.PopupCancelButton.click
end

Then(/^I expect the popup window to close$/) do
  Watir::Wait.until { @pageModel.PopupSaveButton.exists? == false }
end