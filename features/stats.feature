Feature: Pitches
	As an admin
	I want to see stats
	So I can read them

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

	Scenario: Total Number of Users
		Then the "total_number_of_users" should contain "2" 

	Scenario: Number of New Users
		Then the "number_of_new_users" should contain "2" 

	Scenario: Recent Pitches
		Then I should see "Recent Pitches"
		Then I should see "PitchNameOne"

	Scenario: Recent Comments
		Then I should see "Recent Comments"

	Scenario: New Users
		Then I should see "New Users"
		Then I should see "user@gmail.com"





