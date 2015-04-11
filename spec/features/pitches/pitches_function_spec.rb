include Warden::Test::Helpers
Warden.test_mode!

feature 'Pitch functionality' do

  after(:each) do
    Warden.test_reset!
  end

  scenario 'user creates pitch' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit new_pitch_path
    fill_in 'Name', :with => 'testName'
    fill_in 'Category', :with => 'testCategory'
    fill_in 'Media', :with => 'testMedia'
    fill_in 'Text', :with => 'testText'
    click_button 'Create Pitch'
    expect(page).to have_content('Pitch was successfully created.')
  end

  scenario 'user can view a pitch' do
    user = FactoryGirl.create(:user)
    pitch = FactoryGirl.create(:pitch, :user => user)
    login_as(user, :scope => :user)
    visit pitch_path(pitch)
    expect(page).to have_content('testName')
    expect(page).to have_content('testCategory')
    expect(page).to have_content('testMedia')
    expect(page).to have_content('testText')
  end

  scenario 'user can edit a pitch' do
    user = FactoryGirl.create(:user)
    pitch = FactoryGirl.create(:pitch, :user => user)
    login_as(user, :scope => :user)
    visit edit_pitch_path(pitch)
    fill_in 'Name', :with => 'otherName'
    fill_in 'Category', :with => 'otherCategory'
    fill_in 'Media', :with => 'otherMedia'
    fill_in 'Text', :with => 'otherText'
    click_button 'Update Pitch'
    expect(page).to have_content('otherName')
    expect(page).to have_content('otherCategory')
    expect(page).to have_content('otherMedia')
    expect(page).to have_content('otherText')
  end

  scenario 'user can see pitches' do
    user = FactoryGirl.create(:user)
    pitch1 = FactoryGirl.create(:pitch, :name => 'Name 1',:user => user)
    pitch2 = FactoryGirl.create(:pitch, :name => 'Name 2', :user => user)
    login_as(user, :scope => :user)
    visit pitches_path
    expect(page).to have_content('Name 1')
    expect(page).to have_content('Name 2')
  end

end
