Feature: Youth login
	As a registered youth
	I want to login to the website
	So I can upload videos

	Background:
	    Given the following users exist:
	    |name|email|password|confirmed_at|
	    |Test|Test@berkeley.edu|11111111||
	    |test2|test2@gmail.com|11111111|Time.now|


Scenario:
	Given I am on the login page
	Given I am user "test2@gmail.com" is confirmed
	And I fill in "user_email" with "test2@gmail.com"
	And fill in "user_password" with "11111111"
	And I press "sign_in"
	Then I should see "Signed in successfully."
	Given I am on the edit page
	And I fill in "user_name" with "Kemo"
	And I fill in "user_current_password" with "11111111"
	And I press "update_user"
	Then I should see "Your account has been updated successfully."
