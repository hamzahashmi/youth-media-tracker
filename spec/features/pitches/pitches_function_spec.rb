include Warden::Test::Helpers
Warden.test_mode!

feature 'Pitch functionality' do

  after(:each) do
    Warden.test_reset!
  end

  scenario 'user creates pitch for video about art' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit new_pitch_path
    fill_in 'Name', :with => 'testName'
    page.select "Video", :from => "pitch_media"
    page.select "Arts", :from => "pitch_category"
    fill_in 'Description', :with => 'testDescription'
    click_button 'Submit/Update Pitch'
    expect(page).to have_content('Pitch was successfully created.')
  end
  scenario 'user cant create pitch for video about art without name' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit new_pitch_path
    page.select "Video", :from => "pitch_media"
    page.select "Arts", :from => "pitch_category"
    fill_in 'Description', :with => 'testDescription'
    click_button 'Submit/Update Pitch'
    expect(page).to have_content('can\'t be blank')
  end

  scenario 'user can view a pitch for video about art' do
    user = FactoryGirl.create(:user)
    pitch = FactoryGirl.create(:pitch, :user => user, :name => 'testName', :media => 'Video', :category => 'Arts', :description => 'testDescription')
    login_as(user, :scope => :user)
    visit pitch_path(pitch)
    expect(page).to have_content('testName')
    expect(page).to have_content('Video')
    expect(page).to have_content('Arts')
    expect(page).to have_content('testDescription')
  end

  scenario 'user can edit a pitch to now be audio about sports' do
    user = FactoryGirl.create(:user)
    pitch = FactoryGirl.create(:pitch, :user => user, :name => 'testName', :media => 'Video', :category => 'Arts', :description => 'testDescription')
    login_as(user, :scope => :user)
    visit edit_pitch_path(pitch)
    fill_in 'Name', :with => 'otherName'
    page.select "Audio", :from => "pitch_media"
    page.select "Sports", :from => "pitch_category"
    fill_in 'Description', :with => 'otherDescription'
    click_button 'Update Pitch'
    expect(page).to have_content('otherName')
    expect(page).to have_content('Audio')
    expect(page).to have_content('Sports')
    expect(page).to have_content('otherDescription')
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
  scenario 'user can see pitches by most recent' do
    user = FactoryGirl.create(:user)
    pitch1 = FactoryGirl.create(:pitch, :name => 'Name 1',:user => user)
    pitch2 = FactoryGirl.create(:pitch, :name => 'Name 2', :user => user)
    visit pitches_path
    page.body.index('Name 2').should < page.body.index('Name 1')
  end
  scenario 'user can sort pitches by most voted' do
    user = FactoryGirl.create(:user)
    pitch1 = FactoryGirl.create(:pitch, :name => 'Name 1',:user => user)
    pitch2 = FactoryGirl.create(:pitch, :name => 'Name 2', :user => user)
    visit pitches_path
    click_link  "Top Voted"
    click_link  "Most Recent"
    page.body.index('Name 2').should < page.body.index('Name 1')
  end
end
