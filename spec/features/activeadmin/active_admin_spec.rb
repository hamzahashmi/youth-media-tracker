include Warden::Test::Helpers
Warden.test_mode!

feature 'Active Admin functionality' do

	before(:all) do
		user_list = FactoryGirl.create_list(:user, 5, :created_at => 3.months.ago)
		user_list.each do |user|

			pitch = FactoryGirl.create(:pitch, :user => user, :created_at => 2.months.ago)
			
			FactoryGirl.build(:comment, :pitch => pitch, :user => user_list.sample)
			FactoryGirl.build(:comment, :pitch => pitch, :user => user_list.sample)
		end
		unique_user = create(:user, :created_at => 1.year.ago)
		unique_pich = create(:pitch,:user => unique_user, :created_at => 6.months.ago)
		unique_comment = build(:comment, :user => user_list.sample, :created_at => 6.months.ago)

	end
  after(:each) do
    Warden.test_reset!
  end

  scenario 'admin can get to Active Admin route' do
    user = FactoryGirl.create(:user)
    login_as(user)
    visit admin_dashboard_path
    expect(page).to render_template("admin/dashboard/index")
  end
  scenario 'admin can get to Active Admin route' do
    user = FactoryGirl.create(:user)
    login_as(user)
    visit admin_dashboard_path
    expect(page).to have_content('Most Recent')
  end
  
end
