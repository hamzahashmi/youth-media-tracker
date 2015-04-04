Feature: Youth login
	As a registered youth
	I want to login to the website
	So I can upload videos

	Background:
		Given the following zipcodes exist:
		|code|
		|12345|
	    Given the following users exist:
	    |name|email|password|confirmed_at|address_zip_code|phone_number|bio|
	    |Test|Test@berkeley.edu|11111111||12345|123456789|"bio text"|
	    |test2|test2@gmail.com|11111111|Time.now|12345|123456789|"bio text"|



Scenario:
	Given I am on the sign_up page
	And I fill in "user_name" with "Michael Jordan"
	And I fill in "user_email" with "test-ymt-169@berkeley.edu"
	And I fill in "user_password" with "11111111"
	And I fill in "user_password_confirmation" with "11111111"
	And I fill in "user_address_zip_code" with "12345"
	And I fill in "user_phone_number" with "123456789"
	And I fill in "user_bio" with "bio text"
	And I press "submit_"
	Then I should see "A message with a confirmation link has been sent to your email address. Please follow the link to activate your account."

Scenario:
	Given I am on the login page
	And I fill in "user_email" with "Test@berkeley.edu"
	And fill in "user_password" with "11111111"
	And I press "sign_in"
	Then I should see "You have to confirm your email address before continuing."

Scenario:
	Given I am on the login page
	Given I am user "test2@gmail.com" is confirmed
	And I fill in "user_email" with "test2@gmail.com"
	And fill in "user_password" with "11111111"
	And I press "sign_in"
	Then I should see "Signed in successfully."
