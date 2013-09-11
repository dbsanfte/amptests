Feature: Booking holidays in AMP
	In order to allow employees to submit their own holiday requests
	As an employee
	I want to be able to submit holiday requests in AMP

Background:
	Given I am logged in as the Automation Test User


Scenario: The cancel button should close the holiday window and no holiday should be submitted

	Given I am on the profile page
	And I request a new holiday
	And a start date of "18/11/2013"
	And a start time of "AM"
	And an end date of "18/11/2013"
	And an end time of "Midday"
	And information of "information"
	When I click cancel
	Then I expect the popup window to close
	And I expect no holiday to be added

Scenario: The close button should close the holiday window and no holiday should be submitted

	Given I am on the profile page
	And I request a new holiday
	And a start date of "18/11/2013"
	And a start time of "AM"
	And an end date of "18/11/2013"
	And an end time of "Midday"
	And information of "information"
	When I close the popup window
	Then I expect the popup window to close
	And I expect no holiday to be added

Scenario Outline: Add a basic holiday from the landing page
	
	Given I am on the landing page
	And I request a new holiday
	And a start date of "<start_date>"
	And a start time of "<start_time>"
	And an end date of "<end_date>"
	And an end time of "<end_time>"
	And information of "<information>"
	And there are no data validation errors
	When I see the duration calculated
	And I click Save
	Then I expect the popup window to close
	And I expect a link to a new holiday request at "<start_date>" to appear on the page.

	Examples:
		| start_date | start_time | end_date    | end_time |                          information                                |
		| 05/12/2013 |         AM | 05/12/2013  |   Midday | Doctors Appointment - Test Holiday for AMP Testing via Landing Page |

Scenario Outline: Add a basic holiday from the profile page
	
	Given I am on the profile page
	And I request a new holiday
	And a start date of "<start_date>"
	And a start time of "<start_time>"
	And an end date of "<end_date>"
	And an end time of "<end_time>"
	And information of "<information>"
	And there are no data validation errors
	When I see the duration calculated
	And I click Save
	Then I expect the popup window to close
	And I expect a link to a new holiday request at "<start_date>" to appear on the page.

	Examples:
		| start_date | start_time | end_date    | end_time |                               information                              |
		| 06/12/2013 |         AM | 06/12/2013  |   Midday |    Doctors Appointment - Test Holiday for AMP Testing via Profile Page |

Scenario Outline: The duration of a holiday should be automatically calculated by the submission form
	
	Given I am on the profile page
	And I request a new holiday
	And a start date of "<start_date>"
	And a start time of "<start_time>"
	And an end date of "<end_date>"
	And an end time of "<end_time>"
	When I see the duration calculated
	Then I expect a duration of "<duration>"
	
	Examples:
		| start_date | start_time |   end_date | end_time | duration | 
		# Weekday tests:
		| 16/10/2013 |         AM | 16/10/2013 |   Midday |      0.5 |
		| 16/10/2013 |     Midday | 16/10/2013 |       PM |      0.5 |
		| 16/10/2013 |         AM | 16/10/2013 |       PM |        1 |
		| 16/10/2013 |     Midday | 17/10/2013 |   Midday |        1 |
		| 16/10/2013 |         AM | 17/10/2013 |   Midday |      1.5 |
		| 16/10/2013 |     Midday | 17/10/2013 |       PM |      1.5 |
		| 16/10/2013 |         AM | 17/10/2013 |       PM |        2 |
		| 16/10/2013 |     Midday | 18/10/2013 |   Midday |        2 |
		# Over the weekend tests (fri-mon):
		| 18/10/2013 |     Midday | 21/10/2013 |   Midday |        1 | 
		| 18/10/2013 |         AM | 21/10/2013 |   Midday |      1.5 |
		| 18/10/2013 |         AM | 21/10/2013 |       PM |        2 | 
		# Friday-Saturday should only count as one day:
		| 18/10/2013 |         AM | 19/10/2013 |       PM |        1 |
		# Friday-Sunday should only count as one day:
		| 18/10/2013 |         AM | 20/10/2013 |       PM |        1 | 
		# Friday-Sunday (Midday) should only count as one day:
		| 18/10/2013 |         AM | 20/10/2013 |   Midday |        1 | 
		# Over the weekend, monday bank holiday (fri-tues):
		| 23/08/2013 |         AM | 27/08/2013 |   Midday |      1.5 | 
		| 23/08/2013 |     Midday | 27/08/2013 |   Midday |        1 |
		| 23/08/2013 |     Midday | 27/08/2013 |       PM |      1.5 |
		| 23/08/2013 |         AM | 27/08/2013 |       PM |        2 |
		# Bank holidays shouldn't count (half day):
		| 26/08/2013 |         AM | 26/08/2013 |   Midday |        0 | 
		# Bank holidays shouldn't count (half day):
		| 26/08/2013 |     Midday | 26/08/2013 |       PM |        0 | 
		# Bank holidays shouldn't count (full day):
		| 26/08/2013 |         AM | 26/08/2013 |       PM |        0 |
		# entire week, monday-monday:
		| 02/09/2013 |         AM | 09/09/2013 |       PM |        6 |
		# entire month, sunday-sunday
		| 01/09/2013 |         AM | 30/09/2013 |       PM |       21 | 


