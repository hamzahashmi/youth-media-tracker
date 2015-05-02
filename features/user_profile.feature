Feature: Public user's profile
	As a user
	I want to browse profiles
	So I can get to know other

	Background:
		Given the website is set up
		Given I am logged into website as "user"

	Scenario: should able to browse my all profile data
		Given I visit the profile with email "user@gmail.com"
		Then I should see "user"
		Then I should see "Email: user@gmail.com"

	Scenario: should able to browse some others profile data
		Given I visit the profile with email "admin@gmail.com"
		Then I should see "admin"
		Then I should not see "Email: admin@gmail.com"
