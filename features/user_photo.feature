Feature: User photo

  As a user
  So that others can learn more about me
  I want to be able to upload a photo

Background:
  Given the website is set up
  Given I am logged into website as "user"

Scenario: User should be able to change their profile picture
  Given I am on the edit page
  And I upload a photo
  And I fill in "user_current_password" with "11111111"
  And I press "update_user"
  Then I should see "Your account has been updated successfully."
  Given I visit the profile with email "user@gmail.com"
  Then I should see the photo "example.png"