Feature: Sort pitches
	As a registered youth
	I want to sort pitches by recent date/top voted
	So I can easily read them

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

	Scenario: sort pitches by recent date
		Given I am on the home page
		Then I should see "PitchNameTwo" before "PitchNameOne"

	Scenario: sort pitches by top voted
		Given I am on the home page
		When I click vote up on "PitchNameOne"
		When I follow "top-voted"  
		Then I should see "PitchNameOne" before "PitchNameTwo"