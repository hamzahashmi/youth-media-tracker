include Warden::Test::Helpers
Warden.test_mode!

feature 'Schedule settings disables features', :devise do

  after(:each) do
    Warden.test_reset!
  end

  scenario 'user cannot comment before discussion enabled' do
    admin = FactoryGirl.create(:user, :email => "admin@test.com", :role => "admin")
    login_as(admin)

    Timecop.travel(Rails.application.config.start_day.advance(:days => 7))

    visit upmin_path

    fill_in 'schedule_days', :with => '14'
    fill_in 'pitch_day', :with => '6'
    fill_in 'disc_day', :with => '8'
    page.find('#update_scheduling').click

    visit root_path

    expect(page).to have_content(/Pitch submissions currently disabled./)
    expect(page).to have_content(/Discussion starts in 1 days/)
  end
=begin
  scenario "user cannot cannot edit another user's profile", :me do
    me = FactoryGirl.create(:user)
    other = FactoryGirl.create(:user, email: 'other@example.com')
    login_as(me, :scope => :user)
    visit edit_user_registration_path(other)
    expect(page).to have_content 'Edit User'
    expect(page).to have_field('Email', with: me.email)
  end

  scenario 'user cannot view users' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit users_path(user)
    expect(page).to have_content("Access denied.")
  end

  scenario 'admin can update users' do
    admin = FactoryGirl.create(:user, :email => "admin@test.com", :role => "admin")
    user = FactoryGirl.create(:user, :email => "user@test.com")
    login_as(admin)
    visit users_path
    click_button 'changeRole' + user.id.to_s
    expect(page).to have_content("User updated.")
  end
=end
end
