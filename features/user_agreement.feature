Feature: User Agreement 
	As a admin
	I want to users to accept terms and conditions
	In order to keep service rules lawful
Background:
		Given the following zipcodes exist:
		|code|
		|12345|
		
	Scenario: cant sign up without agreeing
		Given I am on the sign_up page
		And I fill in "user_name" with "Michael Jordan"
		And I fill in "user_email" with "test-ymt-169@berkeley.edu"
		And I fill in "user_password" with "11111111"
		And I fill in "user_password_confirmation" with "11111111"
		And I fill in "user_address_zip_code" with "12345"
		And I fill in "user_phone_number" with "123456789"
		And I fill in "user_bio" with "bio text"
		And I press "submit_"
		Then I should see "Agreement must be accepted"
	Scenario: can sign up when agreeing
		Given I am on the sign_up page
		And I fill in "user_name" with "Michael Jordan"
		And I fill in "user_email" with "test-ymt-169@berkeley.edu"
		And I fill in "user_password" with "11111111"
		And I fill in "user_password_confirmation" with "11111111"
		And I fill in "user_address_zip_code" with "12345"
		And I fill in "user_phone_number" with "123456789"
		And I fill in "user_bio" with "bio text"
		And I check "I agree to the Terms of Service"
		And I press "submit_"
		Then I should see "A message with a confirmation link has been sent to your email address. Please follow the link to activate your account."