Feature: Admin view of comments
	As an admin
	I want to see all the comments on the pitches
	So I can understand what youth think 

	Background:
		Given the website is set up
		Given I am logged into website as "admin"
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
	    |2|2|2|great|

	Scenario: see all comments
		Given I am on the admin comments page
		Then I should see "not bad"
		And I should see "great"

	Scenario: Edit a comment
		Given I am on the admin comments page
		Then I follow "1"
		Then I follow "Edit"
		Then I should see "not bad"
		And I should see "Edit Comment"
		When I fill in "comment_body" with "real comment"
		Then I press "Update Comment"
		Then I should see "real comment"
		And I should not see "not bad"
		
	Scenario: Add comment not successful
		Given I am on the admin comments page
		Then I follow "1"
		Then I press "Add Comment"
		Then I should see "Comment wasn't saved, text was empty."

	Scenario: Add comment successful
		Given I am on the admin comments page
		Then I follow "New Comment"
		When I select "user" from "User"
		And I select "PitchNameOne" from "Pitch"
		And I fill in "comment_body" with "this is my comment" 
		And I press "Create Comment"
		Then I should see "this is my comment"
