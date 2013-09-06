require 'watir-webdriver'
require 'rubygems'

# roll our own assert method
def assert
  raise Exception unless yield
end

class Calendar
  def setDate(dateString, browser) 
    date = dateString.split('/')
    monthMap = { "January" => 1, "February" => 2, "March" => 3, "April" => 4, "May" => 5, "June" => 6, "July" => 7, "August" => 8, "September" => 9, "October" => 10, "November" => 11, "December" => 12 }

    if monthMap[browser.span(:class => 'ui-datepicker-month').text] > date[1].to_i || browser.span(:class => 'ui-datepicker-year').text.to_i > date[2].to_i
      # calendar is ahead of our date. go back
      while monthMap[browser.span(:class => 'ui-datepicker-month').text] > date[1].to_i || browser.span(:class => 'ui-datepicker-year').text.to_i > date[2].to_i
        month = browser.span(:class => 'ui-datepicker-month').text
        browser.span(:text => 'Prev').click
        Watir::Wait.until { browser.span(:class => 'ui-datepicker-month').text != month } # wait for calendar to update before next iter
      end
    elsif monthMap[browser.span(:class => 'ui-datepicker-month').text] < date[1].to_i || browser.span(:class => 'ui-datepicker-year').text.to_i < date[2].to_i
      # calendar is behind our date, go forwards
      while monthMap[browser.span(:class => 'ui-datepicker-month').text] < date[1].to_i || browser.span(:class => 'ui-datepicker-year').text.to_i < date[2].to_i
        month = browser.span(:class => 'ui-datepicker-month').text
        browser.span(:text => 'Next').click
        Watir::Wait.until { browser.span(:class => 'ui-datepicker-month').text != month } # wait for calendar to update before next iter
      end 
    end

    browser.link(:text => date[0].to_i.to_s).click # sanitize date[0] in case of leading zeroes on the day
  end
end

Given(/^I am logged in as the Automation Test User$/) do
  @browser.goto 'http://APMTest:cr8qECeb@amptest.bjss.com/' 
end

Given(/^I am on the landing page$/) do
  @browser.goto @BASEURL + '/Landing/Pad'
  @browser.link(:text => 'Landing').when_present.click
end

Given(/^I am on the profile page$/) do
  @browser.goto @BASEURL + '/Landing/Pad'
  @browser.link(:text => 'Profile').when_present.click
  @browser.link(:text => 'Holidays').when_present.click
end

Given(/^I request a new holiday$/) do
  @browser.link(:text => 'New Request').when_present.click
end

Given(/^a start date of "(.*?)"$/) do |arg1|

  @browser.text_field(:id => 'Start').when_present.click
  @browser.text_field(:id => 'Start').fire_event('onfocus')

  Calendar.new.setDate(arg1, @browser)
  Watir::Wait.until { @browser.text_field(:id => 'Start').value == arg1 }
  
  assert { @browser.text_field(:id => 'Start').value == arg1 }
  @startDate = arg1 # save this for a later verification step

end

Given(/^a start time of "(.*?)"$/) do |arg1|
  
  if arg1 != 'AM' && arg1 != 'Midday'
    raise ArgumentException, 'input should be AM or Middday'
  end

  list = @browser.select_list :id => 'StartTime'
  list.exists?
  list.select arg1
end

Given(/^an end date of "(.*?)"$/) do |arg1|

  @browser.text_field(:id => 'Finish').when_present.click
  @browser.text_field(:id => 'Finish').fire_event('onfocus')

  Calendar.new.setDate(arg1, @browser)
  Watir::Wait.until { @browser.text_field(:id => 'Finish').value == arg1 }

  assert { @browser.text_field(:id => 'Finish').value == arg1 }
end

Given(/^an end time of "(.*?)"$/) do |arg1|
  
  if arg1 != 'PM' && arg1 != 'Midday'
    raise ArgumentException, 'input should be PM or Midday'
  end

  list = @browser.select_list :id => 'EndTime'
  list.exists?
  list.select arg1
end

Given(/^a duration of "(.*?)"$/) do |arg1|
  @browser.text_field(:id => 'Duration').set arg1
end

Given(/^holiday information of "(.*?)"$/) do |arg1|
  @browser.text_field(:id => 'Information').set arg1
end

Given(/^there are no data validation errors$/) do
  if @browser.span(:class => 'field-validation-error').exists?
    raise Exception, 'data validation error present in form'
  end
end

When(/^I click Save$/) do
  @browser.span(:text => 'Save').click
end

Then(/^I expect a link to a new holiday request at "(.*?)" to appear on the page\.$/) do |arg1|
  @browser.link(:text => 'View All Requests...').when_present.click
  @browser.link(:text => @startDate).wait_until_present
end

When(/^I see the duration calculated$/) do
  Watir::Wait.until { @browser.text_field(:id => 'Duration').value != '' }
end

Then(/^I expect a duration of "(.*?)"$/) do |arg1|
  assert { @browser.text_field(:id => 'Duration').value == arg1 }
end

When(/^I close the add holiday popup window$/) do
  @browser.span(:text => 'close').click
end

When(/^I click cancel$/) do
  @browser.span(:text => 'Cancel').click
end

Then(/^I expect the holiday window to close$/) do
  Watir::Wait.until { @browser.span(:text => 'Save').exists? == false }
end

Then(/^I expect no holiday to be added$/) do
  @browser.goto @BASEURL + '/Landing/Pad'
  @browser.link(:text => 'Profile').when_present.click
  @browser.link(:text => 'Holidays').when_present.click
  assert { @browser.link(:text => @startDate).exists? == false }
end
