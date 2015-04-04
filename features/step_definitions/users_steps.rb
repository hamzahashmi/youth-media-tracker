# Add a declarative step here for populating the DB with articles.

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
	User.create!(user)   
	end

end

Given /the following zipcodes exist/ do |users_table|
  users_table.hashes.each do |zipcode|
	Zipcode.create!(zipcode)   
	end

end

Given /I am user "(.*)" is confirmed/ do |email|
	user = User.find_by_email(email)
	user.confirmed_at =  Time.now
	user.save!
end