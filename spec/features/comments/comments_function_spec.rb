include Warden::Test::Helpers
Warden.test_mode!

feature 'Comment functionality' do

  after(:each) do
    Warden.test_reset!
  end

  scenario 'user can comment on a pitch and delete their comments' do
    admin = FactoryGirl.create(:user, :email => "admin@test.com", :role => "admin")
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    pitch1 = FactoryGirl.create(:pitch, :name => "A stitch in time saves nine", :user => admin)
    visit pitch_path(pitch1.id)

    fill_in 'comment_body', :with => 'test comment'

    page.find('.btn-primary').click

    expect(page).to have_content('Your comment was added')
    expect(page).to have_content('test comment')
  end

  # scenario 'admin can access all comments' do
  #   admin = FactoryGirl.create(:user, :email => "admin@test.com", :role => "admin")
  #   user = FactoryGirl.create(:user, :email => "user@test.com", :role => "user")
  #   pitch1 = FactoryGirl.create(:pitch, :name => "A stitch in time saves nine", :user => admin)
  #   comment1 = FactoryGirl.create(:comment, :pitch => pitch1, :body => "A test comment", :user => user)

  #   login_as(admin)

  #   visit comments_path

  #   expect(page).to have_content("A test comment")
  # end
end
