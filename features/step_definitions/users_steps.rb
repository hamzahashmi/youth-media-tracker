require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))
Given /the following users exist/ do |users_table|
	users_table.hashes.each do |user|
		User.create!(user)   
	end
end

Given /the following pitches exist/ do |pitches_table|
	pitches_table.hashes.each do |pitch|
		pitch[:user] = @user
		Pitch.create!(pitch)   
	end
end

Given /the following categories exist/ do |categories_table|
	categories_table.hashes.each do |category|
		Category.create!(category)   
	end
end

Given /the following media types exist/ do |media_types_table|
	media_types_table.hashes.each do |type|
		MediaType.create!(type)   
	end
end

Given /the following zipcodes exist/ do |users_table|
	users_table.hashes.each do |zipcode|
		Zipcode.create!(zipcode)   
	end
end

Given /^the website is set up$/ do
	Zipcode.create!(:code => "12345")
	@admin = User.create!(:name => "admin", :email => "admin@gmail.com", :address_zip_code => "12345", :password => "11111111", :bio => "Bio", :phone_number => "123456789")
	@admin.role = "admin"
	@admin.confirmed_at =  Time.now
	@admin.save!
	@user = User.create!(:name => "user", :email => "user@gmail.com", :address_zip_code => "12345", :password => "11111111", :bio => "Bio", :phone_number => "123456789")
	@user.role = "user"
	@user.confirmed_at =  Time.now
	@user.save!
end
Given /email "(.*)" is confirmed/ do |email|
	user = User.find_by_email(email)
	user.confirmed_at =  Time.now
	user.save!
end
Given /I sign out/ do
	visit('/users/sign_out')
end

Given /I am logged into website as "(.*)"/ do  |role|
	visit login_path
	fill_in "Email" ,:with => "#{role}@gmail.com"
	fill_in "Password", :with => "11111111"
	click_link_or_button "sign_in"
end


