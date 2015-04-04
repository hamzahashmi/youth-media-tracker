# Feature: Sign up
#   As a visitor
#   I want to sign up
#   So I can visit protected areas of the site
feature 'Sign Up', :devise do
  
  # Scenario: Visitor can sign up with valid email address and password
  #   Given I am not signed in
  #   When I sign up with a valid email address , password and other required fields
  #   Then I see a successful sign up message
  scenario 'visitor can sign up with valid email address , password and other required fields' do
    sign_up_with('test@example.com', 'please123', 'please123',12345,123456789,"Bio","test")
    txts = [I18n.t( 'devise.registrations.signed_up'), I18n.t( 'devise.registrations.signed_up_but_unconfirmed')]
    expect(page).to have_content(/.*#{txts[0]}.*|.*#{txts[1]}.*/)
  end

  # Scenario: Visitor cannot sign up with invalid email address
  #   Given I am not signed in
  #   When I sign up with an invalid email address
  #   Then I see an invalid email message
  scenario 'visitor cannot sign up with invalid email address' do
    sign_up_with('bogus', 'please123', 'please123',12345,123456789,"Bio","test")
    expect(page).to have_content 'Email is invalid'
  end

  # Scenario: Visitor cannot sign up without password
  #   Given I am not signed in
  #   When I sign up without a password
  #   Then I see a missing password message
  scenario 'visitor cannot sign up without password' do
    sign_up_with('test@example.com', '', '',12345,123456789,"Bio","test")
    expect(page).to have_content "Password can't be blank"
  end

  # Scenario: Visitor cannot sign up with a short password
  #   Given I am not signed in
  #   When I sign up with a short password
  #   Then I see a 'too short password' message
  scenario 'visitor cannot sign up with a short password' do
    sign_up_with('test@example.com', 'please', 'please',12345,123456789,"Bio","test")
    expect(page).to have_content "Password is too short"
  end

  # Scenario: Visitor cannot sign up without password confirmation
  #   Given I am not signed in
  #   When I sign up without a password confirmation
  #   Then I see a missing password confirmation message
  scenario 'visitor cannot sign up without password confirmation' do
    sign_up_with('test@example.com', 'please123', '',12345,123456789,"Bio","test")
    expect(page).to have_content "Password confirmation doesn't match"
  end

  # Scenario: Visitor cannot sign up with mismatched password and confirmation
  #   Given I am not signed in
  #   When I sign up with a mismatched password confirmation
  #   Then I should see a mismatched password message
  scenario 'visitor cannot sign up with mismatched password and confirmation' do
    sign_up_with('test@example.com', 'please123', 'mismatch',12345,123456789,"Bio","test")
    expect(page).to have_content "Password confirmation doesn't match"
  end
  # Scenario: Visitors cannot sign up without phone number
  scenario 'visitor cannot sign up without zip code' do
    sign_up_with('test@example.com', 'please123', 'please123','',123456789,"Bio","test")
    expect(page).to have_content "Address zip code can't be blank"
  end
   # Scenario: Visitors cannot sign up with not allowed zip code
  scenario 'visitor cannot sign up with not allowed zip code' do
    sign_up_with('test@example.com', 'please123', 'please123',94501,123456789,"Bio","test")
    expect(page).to have_content "Address zip code is not covered by our service."
  end

  scenario 'visitor cannot sign up without phone number' do
    sign_up_with('test@example.com', 'please123', 'please123',12345,'',"Bio","test")
    expect(page).to have_content "Phone number can't be blank"
  end

  scenario 'visitor cannot sign up without bio' do
    sign_up_with('test@example.com', 'please123', 'please123',12345,123456789, '',"test")
    expect(page).to have_content "Bio can't be blank"
  end

end
