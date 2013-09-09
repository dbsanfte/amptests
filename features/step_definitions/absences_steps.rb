require 'watir-webdriver'
require 'rubygems'
require_relative '../support/pagemodel.rb'

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