include Warden::Test::Helpers
Warden.test_mode!

feature 'Admin controls' do

  after(:each) do
    Warden.test_reset!
  end

  scenario 'admin views pitches and comments through panel' do
    admin = FactoryGirl.create(:user, :email => "admin@test.com", :role => "admin")
    user = FactoryGirl.create(:user, :email => "user@test.com", :role => "user")
    pitch1 = FactoryGirl.create(:pitch, :name => "A stitch in time", :user => admin)
    pitch2 = FactoryGirl.create(:pitch, :name => "Saves nine", :user => user)

    login_as(admin)
    visit admin_dashboard_path

    expect(page).to have_content('A stitch in time')
    expect(page).to have_content('Saves nine')

    visit '/pitches'

    expect(page).to have_content('A stitch in time')
    expect(page).to have_content('Saves nine')
  end
end