Feature: Youth login
As a registered youth
I want to login to the website
So I can upload videos

Scenario: Invalid Login
Given I am on the login page
And I fill in "user_email" with "test-ymt-169@berkeley.edu"
And fill in "user_password" with "11111111"
And I press "sign_in"
Then I should see "Invalid email or password."