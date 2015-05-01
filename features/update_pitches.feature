Feature: Update pitches
	As a registered youth
	I want to make changes to my pitch
	So I add more information to it

	Background:
		Given the website is set up
		Given I am logged into website as "user"
		Given the following categories exist:
		|id|name|
		|1|"Arts"|
		|2|"Education"|
		Given the following media types exist:
		|id|name|
		|1|"Video"|
		|2|"Audio"|
	    Given the following pitches exist:
	    |id|name|category_id|media_type_id|description|
	    |1|PitchNameOne|1|1| description|
	    |2|PitchNameTwo|1|1| description|

	Scenario: update pitch
		Given I am on the home page
		When I follow "PitchNameOne" 
		When I follow "Edit"
		Then I should see "Edit Pitch"
		When I fill in "Name" with "pitch name"
		And I press "Submit/Update"
		Then I should see "Pitch was successfully updated."