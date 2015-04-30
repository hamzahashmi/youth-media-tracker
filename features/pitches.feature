Feature: Pitches
	As a user
	I want to browse pitches
	So I can read them

	Background:
		Given the website is set up
		Given I am logged into website
		Given the following categories exist:
		|id|name|
		|1|"Arts"|
		|2|"Education"|
		Given the following media types exist:
		|id|name|
		|1|"Video"|
		|2|"Audio"|
	    Given the following pitches exist:
	    |name|category_id|media_type_id|description|
	    |PitchNameOne|1|1| description|
	    |PitchNameTwo|1|2| description|

	Scenario: browse pitches on home screen
		Given I am on the home page
		Then I should see "PitchNameOne"
		Then I should see "PitchNameTwo"

	Scenario: sort pitches by recent
		Given I am on the home page
		Then I should see "PitchNameTwo" before "PitchNameOne"

	Scenario: sort pitches by top voted
		Given I am on the home page
		When I click vote up on "PitchNameOne"
		When I follow "top-voted"  
		Then I should see "PitchNameOne" before "PitchNameTwo"

	Scenario: show pitch
		Given I am on the home page
		When I follow "PitchNameOne"  
		Then I should see "PitchNameOne"

	Scenario: new pitch
		Given I am on the home page
		Given I am on the pitch new page 
		Then I should see "New Pitch"
		When I fill in "Name" with "pitch name"
		When I fill in "Description" with "des"
		And I press "Submit/Update"
		Then I should see "Pitch was successfully created."

	Scenario: update pitch
		Given I am on the home page
		When I follow "PitchNameOne" 
		When I follow "Edit"
		Then I should see "Edit Pitch"
		When I fill in "Name" with "pitch name"
		And I press "Submit/Update"
		Then I should see "Pitch was successfully updated."

