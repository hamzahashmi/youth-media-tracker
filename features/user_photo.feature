Feature: User photo

  As a user
  So that others can learn more about me
  I want to be able to upload a photo

Background:
  Given the website is set up

Scenario: User is able to upload a photo when they sign up
  Given I am on the sign_up page
  And I upload a photo
  And I fill in "user_name" with "Michael Jordan"
  And I fill in "user_email" with "test-ymt@berkeley.edu"
  And I fill in "user_password" with "11111111"
  And I fill in "user_password_confirmation" with "11111111"
  And I fill in "user_address_zip_code" with "12345"
  And I fill in "user_phone_number" with "123456789"
  And I fill in "user_bio" with "bio text"
  And I check "I agree to the Terms of Service"
  And I press "submit_"
  Then I should see "A message with a confirmation link has been sent to your email address. Please follow the link to activate your account."
  Given email "test-ymt@berkeley.edu" is confirmed
  Given I am on the login page
  And I fill in "user_email" with "test-ymt@berkeley.edu"
  And I fill in "user_password" with "11111111"
  And I press "sign_in"
  Then I should see "Signed in successfully."
  Given I visit the profile with email "test-ymt@berkeley.edu"
  Then I should see the photo "example.png"
  
Scenario: User should be able to change their profile picture
  Given I am logged into website as "user"
  Given I am on the edit page
  And I upload a photo
  And I fill in "user_current_password" with "11111111"
  And I press "update_user"
  Then I should see "Your account has been updated successfully."
  Given I visit the profile with email "user@gmail.com"
  Then I should see the photo "example.png"