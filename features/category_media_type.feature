Feature: Add categories/ media type to pitches
	As a user
	I want to select category / media type of a pitech
	So I can submit different types of pitches

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

	 Scenario: new Arts/Video pitch   
		Given I am on the home page
		Given I am on the pitch new page 
		Then I should see "New Pitch"
		When I fill in "Name" with "pitch name"
		When I fill in "Description" with "des"
		And I press "Submit/Update"
		Then I should see "Pitch was successfully created."
		Then I should see "Arts"
		And I should see "Video"
		And I should not see "Audio"

	Scenario: new Education/Audio pitch   
		Given I am on the home page
		Given I am on the pitch new page 
		Then I should see "New Pitch"
		When I fill in "Name" with "pitch name"
		When I fill in "Description" with "des"
		When I select "Education" from "Category"
		When I select "Audio" from "Media type"
		And I press "Submit/Update"
		Then I should see "Pitch was successfully created."
		Then I should see "Education"
		And I should see "Audio"