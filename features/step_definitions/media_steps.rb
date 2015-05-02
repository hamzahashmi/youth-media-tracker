require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

When /I notify "(.*)"/ do |email|
	@user = User.find_by_email(email)
 	@medium = FactoryGirl.create(:medium, :user => @user)
end

Given /I go the final work link/ do
	#get ('/media/#{@medium.id}/edit?token=#{@medium.token}')
	visit edit_medium_path(:id => @medium.id , :token => @medium.token)
end