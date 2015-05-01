Feature: Suspend User
	As a admin
	I want to suspend a user
	In order to remove spam ones
Background:
	Given the website is set up

	Scenario: only admin suspend users
		Given I am logged into website as "user"
		Then I should not see "Admin"

	Scenario: accessing route should not be allowed
		Given I am logged into website as "user"
		When I go to users page
		Then I should see "Access denied."
		Then I should not see "Admin"

	Scenario: accessing route should be allowed to admin
		Given I am logged into website as "admin"
		When I go to users page
		Then I should see "admin@gmail.com"
		Then I should see "Admin"

	Scenario: admin can suspend
		Given I am logged into website as "admin"
		When I go to users page
		When I check "Suspended"
		Then the "Suspended" checkbox should be checked
		Then I press "Change"
		Then the "Suspended" checkbox should be checked
		Then I should see "User updated"

	Scenario: suspended user cant log in
		Given I am logged into website as "admin"
		When I go to users page
		When I check "Suspended"
		Then the "Suspended" checkbox should be checked
		Then I press "Change"
		Given I sign out
		Then I should not see "Admin"
		When I go to the login page
		Then I should see "Sign in"
		When I am logged into website as "user"
		Then I should see "Your account has been suspended by admin"

	Scenario: admin can unsuspend
		Given I am logged into website as "admin"
		When I go to users page
		When I uncheck "Suspended"
		Then I press "Change"
		Then the "Suspended" checkbox should not be checked
