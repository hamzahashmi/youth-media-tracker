Feature: Youth login
As a registered youth
I want to login to the website
So I can upload videos

Scenario:
Given I am on the sign_up page
And I fill in "user_name" with "Michael Jordan"
And I fill in "user_email" with "test-ymt-169@berkeley.edu"
And I fill in "user_password" with "11111111"
And I fill in "user_password_confirmation" with "11111111"
And I press "submit_"
Then I should see "A message with a confirmation link has been sent to your email address. Please follow the link to activate your account."




Scenario:
Given I am on the login page
And I fill in "user_email" with "test-ymt-169@berkeley.edu"
And fill in "user_password" with "11111111"
And I press "sign_in"
Then I should see "You have to confirm your email address before continuing."
