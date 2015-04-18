include Warden::Test::Helpers
Warden.test_mode!

feature 'Admin controls' do

  after(:each) do
    Warden.test_reset!
  end

  scenario 'admin views pitches and comments on dashboard' do
    admin = FactoryGirl.create(:user, :email => "admin@test.com", :role => "admin")
    user = FactoryGirl.create(:user, :email => "user@test.com", :role => "user")
    pitch1 = FactoryGirl.create(:pitch, :name => "A stitch in time saves nine", :user => admin)
    comment1 = FactoryGirl.create(:comment, :pitch => pitch1, :body => "A test comment", :user => user)

    login_as(admin)
    visit admin_dashboard_path

    expect(page).to have_content('A stitch in time saves nine')
    expect(page).to have_content('A test comment')
  end

  scenario 'admin views pitches through panel' do
    admin = FactoryGirl.create(:user, :email => "admin@test.com", :role => "admin")
    user = FactoryGirl.create(:user, :email => "user@test.com", :role => "user")
    pitch1 = FactoryGirl.create(:pitch, :name => "A stitch in time saves nine", :user => admin)
    pitch2 = FactoryGirl.create(:pitch, :name => "Curiosity killed the cat", :user => user)

    login_as(admin)
    visit admin_pitches_path

    expect(page).to have_content('A stitch in time saves nine')
    expect(page).to have_content('Curiosity killed the cat')

    visit admin_pitch_path(pitch1.id)
    expect(page).to have_content('A stitch in time saves nine')
  end

  scenario 'admin views comments through panel' do
    admin = FactoryGirl.create(:user, :email => "admin@test.com", :role => "admin")
    user = FactoryGirl.create(:user, :email => "user@test.com", :role => "user")
    pitch1 = FactoryGirl.create(:pitch, :name => "A stitch in time saves nine", :user => admin)
    comment1 = FactoryGirl.create(:comment, :pitch => pitch1, :body => "A test comment", :user => user)

    login_as(admin)
    visit admin_comments_path

    expect(page).to have_content('A test comment')
  end

  scenario 'admin views users through panel' do
    admin = FactoryGirl.create(:user, :email => "admin@test.com", :role => "admin")
    user = FactoryGirl.create(:user, :name => "John Doe", :email => "user@test.com", :role => "user")
    user2 = FactoryGirl.create(:user, :name => "Hououin Kyouma", :email => "user2@dmail.com", :role => "user")

    login_as(admin)
    visit admin_users_path

    expect(page).to have_content('John Doe')
    expect(page).to have_content('Hououin Kyouma')
  end

  scenario 'admin views zipcodes through panel' do
    admin = FactoryGirl.create(:user, :email => "admin@test.com", :role => "admin")
    zipcode1 = FactoryGirl.create(:zipcode, :code => "94720", :county => "Alameda")

    login_as(admin)
    visit admin_zipcodes_path

    expect(page).to have_content('94720')
    expect(page).to have_content('Alameda')
  end
end