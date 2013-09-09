class AmpPageModel
  def initialize(browser)
    @browser=browser
  end

  def ProfileLink
    @browser.link(:text => 'Profile')
  end

  def LandingLink
    @browser.link(:text => 'Landing')
  end

  def HolidaysLink
    @browser.link(:text => 'Holidays')
  end

  def AbsencesLink
    @browser.link(:text => 'Absences')
  end

  def NewHolidayRequestLink
    @browser.link(:text => 'New Request')
  end

  def ViewAllHolidayRequestsLink
    @browser.link(:text => 'View All Requests...')
  end

  def NewAbsenceRequestLink
    @browser.link(:text => 'New Absence')
  end

  #Holiday/Absence 'popup' ui elements: 
  def PopupSaveButton
    @browser.span(:text => 'Save')
  end

  def PopupCancelButton 
    @browser.span(:text => 'Cancel')
  end

  def StartDateTextField
    @browser.text_field(:id => 'Start')
  end

  def StartTimeDropdownList
    @browser.select_list :id => 'StartTime'
  end

  def FinishDateTextField
    @browser.text_field(:id => 'Finish')
  end

  def FinishTimeDropdownList
    @browser.select_list :id => 'EndTime'
  end

  def DurationTextField
    @browser.text_field(:id => 'Duration')
  end

  def InformationTextField
    @browser.text_field(:id => 'Information')
  end

  def AbsenceReasonDropdownList
    @browser.select_list :id => 'AReason_AbsenceReasonId'
  end

  def PopupWindowCloseButton
    @browser.span(:text => 'close')
  end

  def FieldValidationError
    @browser.span(:class => 'field-validation-error')
  end
end