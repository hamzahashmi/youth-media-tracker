Feature: Comment pitches
	As a registered youth
	I want to comment on pitches
	So I can express my opinion on other pitches

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
	    |1|PitchNameOne|1|1|description|
	    |2|PitchNameTwo|1|1|description|
	    Given the following comments exist:
	    |id|pitch_id|user_id|body|
	    |1|1|2|not bad|
	    |2|1|2|great|

	Scenario: see all comments
		Given I am on the home page
		When I follow "PitchNameOne"
		Then I should see "not bad"
		And I should see "great"

	Scenario: comment on pitch
		Given I am on the home page
		When I follow "PitchNameOne"
		When I fill in "comment_body" with "good"
		And I press "Add Comment"
		Then I should see "Your comment was added"
		And I should see "good"
		Then I press "Add Comment"
		Then I should see "Your comment was NOT added, try again!"
