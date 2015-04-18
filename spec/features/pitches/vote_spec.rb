include Warden::Test::Helpers
Warden.test_mode!

feature 'Vote functionality' do

  after(:each) do
    Warden.test_reset!
  end
  scenario 'user cant vote without login' do
    user = FactoryGirl.create(:user)
    pitch1 = FactoryGirl.create(:pitch, :name => 'Name 1',:user => user)
    visit pitches_path
    click_link  "vote-down" << pitch1.id.to_s
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
  scenario 'user can vote up' do
    user = FactoryGirl.create(:user)
    pitch1 = FactoryGirl.create(:pitch, :name => 'Name 1',:user => user)
    login_as(user, :scope => :user)
    visit pitches_path
    click_link  "vote-up" << pitch1.id.to_s
    have_selector('num-voteup', :description => '1')
  end
  scenario 'user can vote down' do
    user = FactoryGirl.create(:user)
    pitch1 = FactoryGirl.create(:pitch, :name => 'Name 1',:user => user)
    login_as(user, :scope => :user)
    visit pitches_path
    click_link  "vote-down" << pitch1.id.to_s
    have_selector('num-votedown', :description => '1')
  end

end
