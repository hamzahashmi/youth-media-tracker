Feature: Submit final work
	As a admin
	I want to email users who got select
	In order to let them submit final work

	Background:
		Given the website is set up
		Given the following categories exist:
		|id|name|
		|1|"Arts"|
		Given the following media types exist:
		|id|name|
		|1|"Video"|
	    Given the following pitches exist:
	    |id|name|category_id|media_type_id|description|
	    |1|PitchNameOne|1|1| description|
	    Given I am logged into website as "admin"
		When I go to the admin page

	Scenario: should see the option on admin dashboard
		Then I should see "Notify to submit final work"

	Scenario: should be able notify user to submit final work
		When I follow "Notify to submit final work"
		Then I should see "Sent successfully."

	Scenario: should see final work route
		When I go to the home page
		Then I should see "Final Work"
	Scenario: should be able to visit final work route
		When I go to the home page 
		When I follow "Final Work"
		Then I should see "Media"
		Then I should see "Pending Work:"
		Then I should see "Done Work"

	Scenario: should be able to visit final work route
		When I notify "user@gmail.com"
		When I go to the final work page
		Then I should see "user"

	Scenario: user should be able to submit final work
		When I notify "user@gmail.com"
		Given I sign out
		Given I am logged into website as "user"
		Given I go the final work link
		Then I should see "Submit Final Work"
		When I fill in "medium_context" with "Hi"
		When I press "Submit Work"
		Then I should see "Medium was successfully submitted"

	Scenario: user wont able to access media
		Given I sign out
		When I go to the final work page
		Then I should see "Access denied"





