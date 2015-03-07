Feature: Youth login
As a registered youth
I want to login to the website
So I can upload videos

Scenario:
Given I have an authorized account
When I go to the login page
And fill in username with "<username>"
And fill in password with "<password>"
And press "Sign in"
Then I should see the user home page