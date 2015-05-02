include Warden::Test::Helpers
Warden.test_mode!

feature 'User cannot enter invalid schedule settings', :devise do
  after(:each) do
    Warden.test_reset!
  end
=begin
  scenario 'user cannot a negative number of schedule days or archival days' do
    admin = FactoryGirl.create(:user, :email => "admin@test.com", :role => "admin")
    login_as(admin)

    visit admin_scheduling_path

    fill_in 'schedule_days', :with => '-1'
    fill_in 'pitch_day', :with => '7'
    fill_in 'disc_day', :with => '7'
    fill_in 'archive_days', :with => '14'
    page.find('#update_scheduling').click

    expect(page).to have_content(/Invalid number of days per iteration./)

    fill_in 'schedule_days', :with => '14'
    fill_in 'pitch_day', :with => '7'
    fill_in 'disc_day', :with => '7'
    fill_in 'archive_days', :with => '-1'
    page.find('#update_scheduling').click
    expect(page).to have_content(/Invalid archive days./)
  end

  scenario 'pitch and discussion day must be within the iteration' do
    admin = FactoryGirl.create(:user, :email => "admin@test.com", :role => "admin")
    login_as(admin)

    visit admin_scheduling_path

    fill_in 'schedule_days', :with => '14'
    fill_in 'pitch_day', :with => '14'
    fill_in 'disc_day', :with => '7'
    fill_in 'archive_days', :with => '14'
    page.find('#update_scheduling').click

    expect(page).to have_content(/Enter pitch day between 0 and number of days per iteration./)

    fill_in 'schedule_days', :with => '14'
    fill_in 'pitch_day', :with => '7'
    fill_in 'disc_day', :with => '14'
    fill_in 'archive_days', :with => '14'
    page.find('#update_scheduling').click

    expect(page).to have_content(/Enter discussion day between 0 and number of days per iteration./)
  end
end

feature 'Schedule settings disables features', :devise do
  after(:each) do
    Warden.test_reset!
  end

  scenario 'user cannot comment or submit if disabled' do
    admin = FactoryGirl.create(:user, :email => "admin@test.com", :role => "admin")
    pitch = FactoryGirl.create(:pitch, :name => "FakePitch")
    login_as(admin)

    Timecop.travel(Rails.application.config.start_day.advance(:days => 7))

    visit admin_scheduling_path

    fill_in 'schedule_days', :with => '14'
    fill_in 'pitch_day', :with => '6'
    fill_in 'disc_day', :with => '8'
    page.find('#update_scheduling').click

    expect(page).to have_content(/Scheduling successfully updated./)

    visit root_path

    expect(page).to have_content(/Pitch submissions currently disabled./)
    expect(page).to have_content(/Discussion starts in 1 days/)

    visit new_pitch_path

    expect(page).to have_content(/Pitch submissions are currently disabled./)
    page.find('.btn-primary').click
    expect(page).to have_content(/Sorry, pitch submissions are currently disabled./)

    visit pitch_path(pitch.id)

    expect(page).to have_content(/Discussion currently disabled./)

    fill_in 'comment_body', :with => "FakeComment"
    page.find('.btn-primary').click
    expect(page).to have_no_content(/FakeComment/)
  end
  
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
