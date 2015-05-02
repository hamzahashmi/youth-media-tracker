require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

When(/^I set iteration to end at (\d+):(\d+) pm$/) do |hour, min|
	if hour.to_i > 12
		select((hour.to_i - 12).to_s, :from => "end_hour")
		select("pm", :from => "end_ampm")
	else
		select(hour, :from => "end_hour")
		select("pm", :from => "end_ampm")
	end
	select(min.to_s, :from => "end_min")
	click_link_or_button "Save changes"
end


When(/^I try to upvote an old pitch$/) do
	Zipcode.create(:code => 95531)
	@user = User.create!(:name => "John", :address_zip_code => 95531, 
						 :phone_number => "1111111111", :bio => "bio",
						 :email => "a@gmail.com", :password => "password")
	@media_type = MediaType.create!(:name => "Media")
	@category = Category.create!(:name => "Category")
	@pitch = Pitch.create!(:name => "Name", :media_type_id => 1, :category_id => 1, :description => "Description", 
						   :created_at => 2.weeks.ago, :user => @user)
	step 'go to the home page'
	click_link_or_button "vote-up" << @pitch.id.to_s
end
