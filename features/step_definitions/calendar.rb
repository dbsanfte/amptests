class Calendar
  def initialize(browser)
    @browser = browser;
  end

  def setDate(dateString) 
    date = dateString.split('/')
    monthMap = { "January" => 1, "February" => 2, "March" => 3, "April" => 4, "May" => 5, "June" => 6, "July" => 7, "August" => 8, "September" => 9, "October" => 10, "November" => 11, "December" => 12 }

    if monthMap[@browser.span(:class => 'ui-datepicker-month').text] > date[1].to_i || @browser.span(:class => 'ui-datepicker-year').text.to_i > date[2].to_i
      # calendar is ahead of our date. go back
      while monthMap[@browser.span(:class => 'ui-datepicker-month').text] > date[1].to_i || @browser.span(:class => 'ui-datepicker-year').text.to_i > date[2].to_i
        month = @browser.span(:class => 'ui-datepicker-month').text
        @browser.span(:text => 'Prev').click
        Watir::Wait.until { @browser.span(:class => 'ui-datepicker-month').text != month } # wait for calendar to update before next iter
      end
    elsif monthMap[@browser.span(:class => 'ui-datepicker-month').text] < date[1].to_i || @browser.span(:class => 'ui-datepicker-year').text.to_i < date[2].to_i
      # calendar is behind our date, go forwards
      while monthMap[@browser.span(:class => 'ui-datepicker-month').text] < date[1].to_i || @browser.span(:class => 'ui-datepicker-year').text.to_i < date[2].to_i
        month = @browser.span(:class => 'ui-datepicker-month').text
        @browser.span(:text => 'Next').click
        Watir::Wait.until { @browser.span(:class => 'ui-datepicker-month').text != month } # wait for calendar to update before next iter
      end 
    end

    @browser.div(:id => 'ui-datepicker-div').fire_event('onfocus')
    @browser.span(:class => 'ui-datepicker-year').fire_event('onfocus')
    @browser.span(:class => 'ui-datepicker-month').fire_event('onfocus')
    
    @browser.link(:text => date[0].to_i.to_s).click # sanitize date[0] in case of leading zeroes on the day
  end
end