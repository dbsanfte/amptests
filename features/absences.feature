Feature: Booking absences in AMP
	In order to allow employees to submit their own absence requests
	As an employee
	I want to be able to submit absence requests in AMP

Background:
	Given I am logged in as the Automation Test User


Scenario Outline: Add a basic absence from the landing page

	Given I am on the landing page
	And I request a new absence
	And a start date of "<start_date>"
	And a start time of "<start_time>"
	And an end date of "<end_date>"
	And an end time of "<end_time>"
	And a reason of "<reason>"
	And information of "<information>"
	And there are no data validation errors
	When I see the duration calculated
	And I click Save
	Then I expect a link to a new absence request at "<start_date>" to appear on the page.

	Examples:
		| start_date | start_time | end_date   | end_time |   reason |                          information                                |
		| 20/12/2013 |         AM | 20/12/2013 |   Midday |  Illness | Doctors Appointment - Test Absence for AMP Testing via Landing Page |

Scenario Outline: Add a basic absence from the profile page

	Given I am on the profile page
	And I request a new absence
	And a start date of "<start_date>"
	And a start time of "<start_time>"
	And an end date of "<end_date>"
	And an end time of "<end_time>"
	And a reason of "<reason>"
	And information of "<information>"
	And there are no data validation errors
	When I see the duration calculated
	And I click Save
	Then I expect a link to a new absence request at "<start_date>" to appear on the page.

	Examples:
		| start_date | start_time | end_date   | end_time |   reason |                          information                                |
		| 19/12/2013 |         AM | 19/12/2013 |   Midday |  Illness | Doctors Appointment - Test Absence for AMP Testing via Profile Page |
