Feature: Vote on pitches
	As a registered youth
	I want to vote on pitches
	So I can appreciate other youth's works

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

	Scenario: vote up for pitch
		Given I am on the home page
		When I click vote up on "PitchNameOne"
		Then the "vote-up1" should contain "1" 
		When I click vote down on "PitchNameOne"
		Then the "vote-up1" should contain "0" 

	Scenario: cant vote down
		Given I am on the home page
		Then I can not find "vote-down1"