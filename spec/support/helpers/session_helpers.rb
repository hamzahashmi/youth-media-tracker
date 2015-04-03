module Features
  module SessionHelpers
    def sign_up_with(email, password, confirmation,zip_code,phone_number,bio,name)
      FactoryGirl.create(:zipcode)
      visit new_user_registration_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'Password confirmation', :with => confirmation
      fill_in 'user_address_zip_code', :with => zip_code
      fill_in 'Phone number', :with => phone_number
      fill_in 'Bio', :with => bio
      fill_in 'Name', :with => name
      click_button 'Sign up'
    end

    def signin(email, password)
      visit new_user_session_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Sign in'
    end
  end
end
