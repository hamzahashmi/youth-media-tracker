Feature: Browse pitches
	As a registered youth
	I want to browse all the pitches
	So I can look at others' ideas

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

	Scenario: browse pitches on home screen
		Given I am on the home page
		Then I should see "PitchNameOne"
		Then I should see "PitchNameTwo"

	Scenario: show pitch
		Given I am on the home page
		When I follow "PitchNameOne"  
		Then I should see "PitchNameOne"