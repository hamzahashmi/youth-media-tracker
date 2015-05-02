Feature: Scheduling
	As a admin
	I want to set iteration deadlines
	In order to keep on schedule

Background:
	Given the website is set up

Scenario: Change pitch deadline
	Given I am logged into website as "admin"
	When I go to the scheduling options page
	And I set iteration to end at 3:30 pm
	And I go to the home page
	Then I should see "Current iteration ends on"
	And I should see "15:30"

Scenario: Disable voting on previous iteration
	Given I am logged into website as "user"
	When I try to upvote an old pitch
	Then I should see "Cannot vote on previous iteration's pitches"