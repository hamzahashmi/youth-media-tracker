Feature: User login
	As a registered youth
	I want to login to the website
	So I can upload videos
Background:
		Given the following zipcodes exist:
		|code|
		|12345|
	    Given the following users exist:
	    |name|email|password|confirmed_at|address_zip_code|phone_number|bio|
	    |Test|test@berkeley.edu|11111111||12345|123456789|"bio text"|
	    |test2|test2@gmail.com|11111111|Time.now|12345|123456789|"bio text"|

Scenario: Invalid Login
	Given I am on the login page
	And I fill in "user_email" with "test-ymt-169@berkeley.edu"
	And fill in "user_password" with "11111111"
	And I press "sign_in"
	Then I should see "Invalid email or password."

Scenario: confirm email 
	Given I am on the login page
	And I fill in "user_email" with "test@berkeley.edu"
	And fill in "user_password" with "11111111"
	And I press "sign_in"
	Then I should see "You have to confirm your email address before continuing."

Scenario: valid login 
	Given I am on the login page
	Given email "test2@gmail.com" is confirmed
	And I fill in "user_email" with "test2@gmail.com"
	And fill in "user_password" with "11111111"
	And I press "sign_in"
	Then I should see "Signed in successfully."